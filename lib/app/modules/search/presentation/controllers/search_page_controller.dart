import 'package:flutter/material.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/get_enabled_usecases.dart';

part 'search_page_controller.g.dart';

class SearchPageController = _SearchPageControllerBase
    with _$SearchPageController;

abstract class _SearchPageControllerBase with Store {
  final GetEnabledUsecases _getEnabledUsecases;

  _SearchPageControllerBase(this._getEnabledUsecases) {
    _getUsecases();
  }

  @observable
  var searchTextFieldController = TextEditingController();

  @observable
  var magnetLinks = <MagnetLink>[].asObservable();

  @observable
  var enabledUsecases = [];

  @observable
  String errorMessage;

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

  @action
  Future<void> performSearch(String content) async {
    errorMessage = null;
    magnetLinks.clear();

    for (var usecase in enabledUsecases) {
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
          right.listen((MagnetLink magnetLink) {
            magnetLinks.add(magnetLink);
          });
        },
      );
    }
  }
}
