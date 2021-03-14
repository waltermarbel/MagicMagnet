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
  SearchState state = InitialState();

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
      (left) => state = FatalErrorState(),
      (right) => enabledUsecases = right.toList(),
    );

    print('Usecases quantity: ${enabledUsecases.length}');
  }

  @action
  void cancelSearch(String content) {
    state = CancelledSearchState(content);
    magnetLinks.clear();
  }

  @action
  Future<void> performSearch(String content) async {
    await _getUsecases();

    print(enabledUsecases);

    if (enabledUsecases.isEmpty) {
      state = FatalErrorState();
    } else {
      magnetLinks.clear();

      var finishedCounter = 0;

      for (var usecase in enabledUsecases) {
        final result = usecase(SearchParameters(content));

        result.fold(
          (left) {
            if (left is InvalidSearchParametersFailure) {
              state = FatalErrorState();
            } else {
              state = SearchErrorState(content);
            }
          },
          (right) async {
            StreamSubscription<MagnetLink> stream;

            stream = right.listen(
              (magnetLink) async {
                if (state is ErrorState || state is FinishedSearchState) {
                  stream.cancel();
                  magnetLinks.clear();
                }

                final index = _addMagnetLink(magnetLink);

                if (state is InitialState) {
                  state = SearchingContentState(content);
                }

                if (usecase is GetMagnetLinksFromGoogle ||
                    usecase is GetMagnetLinksFromYTS) {
                  final result = await _getInfoForMagnetLink(magnetLink);

                  result.fold(
                    (left) => state = SearchErrorState(content),
                    (right) {
                      magnetLinks.elementAt(index).magnetLinkInfo = right;
                    },
                  );
                }
              },
              onDone: () {
                finishedCounter++;

                if (finishedCounter == enabledUsecases.length) {
                  state = FinishedSearchState(content);
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
