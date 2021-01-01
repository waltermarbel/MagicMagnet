import 'package:flutter/material.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/get_enabled_usecases.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final GetEnabledUsecases _getEnabledUsecases;

  _AppControllerBase(this._getEnabledUsecases) {
    _getUsecases();
  }

  @observable
  var magnetLinks = <MagnetLink>[].asObservable();

  @observable
  var searchTextFieldController = TextEditingController();

  @observable
  var enabledUsecases = [];

  @action
  Future<void> _getUsecases() async {
    final result = await _getEnabledUsecases(NoParams());

    result.fold(
      (left) => print(left),
      (right) {
        print(right);
        enabledUsecases = right;
      },
    );
  }

  @observable
  String errorMessage;

  @action
  Future<void> performSearch() async {
    errorMessage = null;
    magnetLinks.clear();

    for (var usecase in enabledUsecases) {
      final result = usecase(SearchParameters(searchTextFieldController.text));

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
