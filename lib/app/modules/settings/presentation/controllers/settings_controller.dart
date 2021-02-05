import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/domain/entities/usecase_entity.dart';
import '../../../../core/domain/usecases/disable_usecase.dart';
import '../../../../core/domain/usecases/enable_usecase.dart';
import '../../../../core/domain/usecases/get_enabled_usecases.dart';
import '../../../../core/domain/usecases/get_preferred_theme.dart';
import '../../../../core/domain/usecases/set_preferred_theme.dart';
import '../../../../core/utils/user_interface/themes.dart';

part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  final GetEnabledUsecases _getEnabledUsecases;
  final EnableUsecase _enableUsecase;
  final DisableUsecase _disableUsecase;
  final GetPreferredTheme _getPreferredTheme;
  final SetPreferredTheme _setPreferredTheme;

  _SettingsControllerBase(this._getEnabledUsecases, this._enableUsecase,
      this._disableUsecase, this._getPreferredTheme, this._setPreferredTheme) {
    _getUsecases();
  }

  @observable
  var enabledUsecases = [].asObservable();

  @observable
  var isGoogleEnabled = false;

  @observable
  var isTPBEnabled = false;

  @observable
  var is1337XEnabled = false;

  @observable
  var isNyaaEnabled = false;

  @observable
  var isEZTVEnabled = false;

  @observable
  var isYTSEnabled = false;

  @observable
  var isLimeTorrentsEnabled = false;

  @observable
  var appTheme = lightTheme;

  @computed
  Themes get currentTheme =>
      appTheme == lightTheme ? Themes.light : Themes.dark;

  @action
  fetchPreferredTheme() async {
    final result = await _getPreferredTheme(NoParams());
    result.fold(
      (left) => print(left),
      (right) async {
        if (right == Themes.light) {
          await changeAppTheme(theme: Themes.light);
        } else {
          await changeAppTheme(theme: Themes.dark);
        }
      },
    );
  }

  @action
  Future<void> changeAppTheme({Themes theme}) async {
    if (theme != null) {
      if (theme == Themes.dark) {
        appTheme = darkTheme;
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: Colors.black));
      } else {
        appTheme = lightTheme;
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: Color(0xFFFFFEFE)));
      }

      await _setPreferredTheme(theme);
    } else {
      var brightness = WidgetsBinding.instance.window.platformBrightness;

      if (brightness == Brightness.dark) {
        appTheme = darkTheme;
        await _setPreferredTheme(Themes.dark);
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: Colors.black));
      } else {
        appTheme = lightTheme;
        await _setPreferredTheme(Themes.light);
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: Color(0xFFFFFEFE)));
      }
    }
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

    if (usecase.key == 'LimeTorrents') {
      isLimeTorrentsEnabled = value;
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
        isLimeTorrentsEnabled =
            _hasUsecaseOfType<GetMagnetLinksFromLimeTorrents>();
      },
    );
  }
}
