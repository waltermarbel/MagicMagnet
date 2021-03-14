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
  }

  @action
  Future<void> performSearch(String content) async {
    await _getUsecases();

    print(enabledUsecases);

    if (enabledUsecases.isEmpty) {
      state = FatalErrorState();
    } else {
      magnetLinks.clear();

      state = SearchingState(content);

      var finishedCounter = 0;

      for (var usecase in enabledUsecases) {
        final result = usecase(SearchParameters(content));

        result.fold(
          (left) {
            if (left.runtimeType == InvalidSearchParametersFailure) {
              state = FatalErrorState();
            } else {
              state = ErrorState(content);
            }
          },
          (right) async {
            StreamSubscription<MagnetLink> stream;

            stream = right.listen(
              (magnetLink) async {
                if (state.runtimeType == FatalErrorState ||
                    state.runtimeType == ErrorState ||
                    state.runtimeType == CancelledSearchState ||
                    state.runtimeType == FinishedState) {
                  stream.cancel();
                }

                final index = _addMagnetLink(magnetLink);

                if (usecase.runtimeType == GetMagnetLinksFromGoogle ||
                    usecase.runtimeType == GetMagnetLinksFromYTS) {
                  final result = await _getInfoForMagnetLink(magnetLink);

                  result.fold(
                    (left) => state = ErrorState(content),
                    (right) {
                      magnetLinks.elementAt(index).magnetLinkInfo = right;
                    },
                  );
                }
              },
              onDone: () {
                finishedCounter++;

                if (finishedCounter == enabledUsecases.length) {
                  state = FinishedState(content);
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
