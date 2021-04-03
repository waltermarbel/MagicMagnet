import 'dart:async';

import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/domain/usecases/get_enabled_search_providers.dart';
import '../../../../core/domain/usecases/get_trackers.dart';
import 'search_states.dart';

part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final GetInfoForMagnetLink _getInfoForMagnetLink;
  final GetEnabledSearchProviders _getSearchProviders;
  final GetTrackers _getTrackers;

  _SearchControllerBase(
    this._getInfoForMagnetLink,
    this._getSearchProviders,
    this._getTrackers,
  );

  @observable
  SearchState state = SearchState.idle;

  @observable
  var magnetLinks = <MagnetLink>[].asObservable();

  var _searchProviders = <Usecase<Stream<MagnetLink>, SearchParameters>>[];

  @action
  int _addMagnetLink(MagnetLink magnetLink) {
    magnetLinks.add(magnetLink);
    return magnetLinks.indexOf(magnetLink);
  }

  @action
  Future<void> _getUsecases() async {
    final result = await _getSearchProviders(NoParams());

    result.fold(
      (left) => state = SearchState.fatalError,
      (right) => _searchProviders = right.toList(),
    );

    print('Usecases quantity: ${_searchProviders.length}');
  }

  @action
  void cancelSearch(String content) {
    state = SearchState.cancelled;
    magnetLinks.clear();
  }

  @action
  Future<void> performSearch(String content) async {
    await _getUsecases();
    final result = await _getTrackers(NoParams());
    var trackers = <Tracker>[];

    result.fold(
      (failure) => state = SearchState.fatalError,
      (success) => trackers = success,
    );

    print(_searchProviders);

    if (_searchProviders.isEmpty) {
      state = SearchState.fatalError;
    } else {
      magnetLinks.clear();

      var finishedCounter = 0;

      for (var searchProviderUsecase in _searchProviders) {
        final result = searchProviderUsecase(SearchParameters(content));

        result.fold(
          (left) {
            if (left is InvalidSearchParametersFailure) {
              state = SearchState.fatalError;
            } else {
              state = SearchState.error;
            }
          },
          (right) async {
            StreamSubscription<MagnetLink> stream;

            stream = right.listen(
              (magnetLink) async {
                if (state == SearchState.cancelled || state == SearchState.error || state == SearchState.finished) {
                  stream.cancel();
                }

                final index = _addMagnetLink(magnetLink);

                if (state == SearchState.idle) {
                  state = SearchState.searching;
                }

                if (searchProviderUsecase is GetMagnetLinksFromGoogle ||
                    searchProviderUsecase is GetMagnetLinksFromYTS) {
                  final result = await _getInfoForMagnetLink(InfoParams(magnetLink, trackers.sublist(0, 2)));

                  result.fold(
                    (left) => state = SearchState.error,
                    (right) {
                      magnetLinks.elementAt(index).magnetLinkInfo = right;
                    },
                  );
                }
              },
              onDone: () {
                finishedCounter++;

                if (finishedCounter == _searchProviders.length) {
                  state = SearchState.finished;
                  stream.cancel();
                }
              },
            );
          },
        );
      }
    }
  }
}
