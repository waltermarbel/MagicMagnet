import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/usecase_entity.dart';
import '../../domain/usecases/disable_usecase.dart';
import '../../domain/usecases/enable_usecase.dart';
import '../../domain/usecases/get_enabled_usecases.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final GetEnabledUsecases _getEnabledUsecases;
  final EnableUsecase _enableUsecase;
  final DisableUsecase _disableUsecase;
  final GetInfoForMagnetLink _getInfoForMagnetLink;

  _AppControllerBase(
    this._getEnabledUsecases,
    this._enableUsecase,
    this._disableUsecase,
    this._getInfoForMagnetLink,
  ) {
    _getUsecases();
  }

  @observable
  var magnetLinks = <MagnetLink>[].asObservable();

  @observable
  var searchTextFieldController = TextEditingController();

  @observable
  var enabledUsecases = [].asObservable();

  @observable
  var isGoogleEnabled;

  @observable
  var isTPBEnabled;

  @observable
  var is1337XEnabled;

  @observable
  var isNyaaEnabled;

  @observable
  var isEZTVEnabled;

  @observable
  var isYTSEnabled;

  @observable
  String errorMessage = '';

  @observable
  var hasCancelRequest = false;

  @observable
  var hasFinishedSearch = false;

  @action
  int addMagnetLink(MagnetLink magnetLink) {
    magnetLinks.add(magnetLink);
    return magnetLinks.indexOf(magnetLink);
  }

  @action
  void cancelSearch() {
    hasCancelRequest = true;
  }

  @action
  bool _hasUsecaseOfType<T>() {
    for (var usecase in enabledUsecases) {
      if (usecase.runtimeType == T) {
        return true;
      }
    }

    return false;
  }

  @action
  Future<void> enableUsecase(UsecaseEntity usecase) async {
    final result = await _enableUsecase(usecase);

    result.fold((l) => print(l), (r) {
      _changeUsecaseValue(usecase: usecase, value: true);

      enabledUsecases.add(r);
      print(enabledUsecases);
    });
  }

  @action
  void clearErrorMessage() => errorMessage = '';

  @action
  void markAsFinished() => hasFinishedSearch = true;

  @action
  void _changeUsecaseValue({UsecaseEntity usecase, bool value}) {
    if (usecase.key == 'Google') {
      isGoogleEnabled = value;
    }

    if (usecase.key == 'The Pirate Bay') {
      isTPBEnabled = value;
    }

    if (usecase.key == '1337x') {
      is1337XEnabled = value;
    }

    if (usecase.key == 'Nyaa') {
      isNyaaEnabled = value;
    }

    if (usecase.key == 'EZTV') {
      isEZTVEnabled = value;
    }

    if (usecase.key == 'YTS') {
      isYTSEnabled = value;
    }
  }

  @action
  Future<void> disableUsecase<T>(UsecaseEntity usecase) async {
    enabledUsecases.removeWhere((element) => element.runtimeType == T);
    _changeUsecaseValue(usecase: usecase, value: false);
    await _disableUsecase(usecase);
    print(enabledUsecases);
  }

  @action
  Future<void> _getUsecases() async {
    final result = await _getEnabledUsecases(NoParams());

    result.fold(
      (left) => print(left),
      (right) {
        print(right);
        enabledUsecases = right.asObservable();
        isGoogleEnabled = _hasUsecaseOfType<GetMagnetLinksFromGoogle>();
        isTPBEnabled = _hasUsecaseOfType<GetMagnetLinksFromTPB>();
        is1337XEnabled = _hasUsecaseOfType<GetMagnetLinksFrom1337X>();
        isNyaaEnabled = _hasUsecaseOfType<GetMagnetLinksFromNyaa>();
        isEZTVEnabled = _hasUsecaseOfType<GetMagnetLinksFromEZTV>();
        isYTSEnabled = _hasUsecaseOfType<GetMagnetLinksFromYTS>();
      },
    );
  }

  @action
  Future<void> performSearch() async {
    hasFinishedSearch = false;
    clearErrorMessage();
    hasCancelRequest = false;
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

          cancelSearch();
        },
        (Stream<MagnetLink> right) async {
          StreamSubscription<MagnetLink> stream;

          stream = right.listen((magnetLink) async {
            if (hasCancelRequest) {
              stream.cancel();
              cancelSearch();
            } else {
              final index = addMagnetLink(magnetLink);

              final result = await _getInfoForMagnetLink(magnetLink);

              result.fold((l) => print(l), (right) {
                magnetLinks.elementAt(index).magnetLinkInfo = right;
              });
            }
          }, onDone: () {
            markAsFinished();
            print(hasFinishedSearch);
          });
        },
      );
    }
  }
}
