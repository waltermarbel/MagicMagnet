import 'package:flutter/material.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/presentation/controllers/app_controller.dart';

part 'search_page_controller.g.dart';

class SearchPageController = _SearchPageControllerBase
    with _$SearchPageController;

abstract class _SearchPageControllerBase with Store {
  final AppController _appController;

  _SearchPageControllerBase(this._appController);

  @observable
  var searchTextFieldController = TextEditingController();

  @observable
  var magnetLinks = <MagnetLink>[].asObservable();

  @observable
  String errorMessage;

  @action
  Future<void> performSearch(String content) async {
    errorMessage = null;
    magnetLinks.clear();

    for (var usecase in _appController.enabledUsecases) {
      final result = usecase(SearchParameters(content));

      result.fold(
        (left) {
          if (left.runtimeType == InvalidSearchParametersFailure) {
            errorMessage = 'Invalid search term';
          } else {
            errorMessage = 'An error occurred';
          }
        },
        (right) {
          right.listen(
            (MagnetLink magnetLink) {
              magnetLinks.add(magnetLink);
            },
          );
        },
      );
    }
  }
}
