import 'dart:async';

import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/domain/usecases/get_enabled_usecases.dart';
import 'search_states.dart';

part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final GetInfoForMagnetLink _getInfoForMagnetLink;
  final GetEnabledUsecases _getEnabledUsecases;

  _SearchControllerBase(
    this._getInfoForMagnetLink,
    this._getEnabledUsecases,
  );

  @observable
  SearchState state = SearchState.idle;

  @observable
  var magnetLinks = <MagnetLink>[].asObservable();

  var enabledUsecases = <Usecase<Stream<MagnetLink>, SearchParameters>>[];

  @action
  int _addMagnetLink(MagnetLink magnetLink) {
    magnetLinks.add(magnetLink);
    return magnetLinks.indexOf(magnetLink);
  }

  @action
  Future<void> _getUsecases() async {
    final result = await _getEnabledUsecases(NoParams());

    result.fold(
      (left) => state = SearchState.fatalError,
      (right) => enabledUsecases = right.toList(),
    );

    print('Usecases quantity: ${enabledUsecases.length}');
  }

  @action
  void cancelSearch(String content) {
    state = SearchState.cancelled;
    magnetLinks.clear();
  }

  @action
  Future<void> performSearch(String content) async {
    await _getUsecases();

    print(enabledUsecases);

    if (enabledUsecases.isEmpty) {
      state = SearchState.fatalError;
    } else {
      magnetLinks.clear();

      var finishedCounter = 0;

      for (var usecase in enabledUsecases) {
        final result = usecase(SearchParameters(content));

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
                if (state == SearchState.cancelled ||
                    state == SearchState.error ||
                    state == SearchState.finished) {
                  stream.cancel();
                }

                final index = _addMagnetLink(magnetLink);

                if (state == SearchState.idle) {
                  state = SearchState.searching;
                }

                if (usecase is GetMagnetLinksFromGoogle ||
                    usecase is GetMagnetLinksFromYTS) {
                  final result = await _getInfoForMagnetLink(magnetLink);

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

                if (finishedCounter == enabledUsecases.length) {
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
