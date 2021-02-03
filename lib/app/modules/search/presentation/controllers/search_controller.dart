import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../../settings/presentation/controllers/settings_controller.dart';

part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final GetInfoForMagnetLink _getInfoForMagnetLink;

  _SearchControllerBase(this._getInfoForMagnetLink);

  @observable
  var magnetLinks = <MagnetLink>[].asObservable();

  @observable
  String errorMessage = '';

  @observable
  var hasCancelRequest = false;

  @observable
  var hasFinishedSearch = false;

  @action
  void cancelSearch() {
    hasCancelRequest = true;
  }

  @action
  void clearErrorMessage() => errorMessage = '';

  @action
  void markAsFinished() => hasFinishedSearch = true;

  @action
  int addMagnetLink(MagnetLink magnetLink) {
    magnetLinks.add(magnetLink);
    return magnetLinks.indexOf(magnetLink);
  }

  @action
  Future<void> performSearch(String content) async {
    var finishCounter = 0;
    hasFinishedSearch = false;
    hasCancelRequest = false;

    magnetLinks.clear();
    clearErrorMessage();

    final enabledUsecases = Modular.get<SettingsController>().enabledUsecases;

    for (var usecase in enabledUsecases) {
      final result = usecase(SearchParameters(content));

      result.fold(
        (left) {
          if (left.runtimeType == InvalidSearchParametersFailure) {
            errorMessage = 'Invalid search term';
          } else {
            errorMessage = 'An error occurred';
          }

          cancelSearch();
        },
        (Stream<MagnetLink> right) async {
          StreamSubscription<MagnetLink> stream;

          stream = right.listen(
            (magnetLink) async {
              if (hasCancelRequest) {
                stream.cancel();
                cancelSearch();
              } else {
                final index = addMagnetLink(magnetLink);

                if (usecase.runtimeType == GetMagnetLinksFromGoogle ||
                    usecase.runtimeType == GetMagnetLinksFromYTS) {
                  final result = await _getInfoForMagnetLink(magnetLink);
                  result.fold(
                    (l) => print(l),
                    (right) {
                      magnetLinks.elementAt(index).magnetLinkInfo = right;
                    },
                  );
                }
              }
            },
            onDone: () {
              finishCounter++;

              if (finishCounter == enabledUsecases.length) {
                markAsFinished();
                print('Searched has finished successfully');
              }
            },
          );
        },
      );
    }
  }
}
