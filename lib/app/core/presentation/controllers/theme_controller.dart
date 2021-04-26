import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../domain/usecases/get_preferred_theme.dart';
import '../../domain/usecases/set_preferred_theme.dart';
import '../../utils/user_interface/themes.dart';

part 'theme_controller.g.dart';

class ThemeController = _ThemeControllerBase with _$ThemeController;

abstract class _ThemeControllerBase with Store {
  final SetPreferredTheme _setPreferredTheme;
  final GetPreferredTheme _getPreferredTheme;

  _ThemeControllerBase(this._setPreferredTheme, this._getPreferredTheme);

  @observable
  var appTheme = lightTheme;

  @computed
  Themes get currentTheme =>
      appTheme == lightTheme ? Themes.light : Themes.dark;

  @action
  Future<void> fetchPreferredTheme() async {
    final result = await _getPreferredTheme(NoParams());
    result.fold(
      (left) => debugPrint(left.toString()),
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
            const SystemUiOverlayStyle(statusBarColor: Colors.black));
      } else {
        appTheme = lightTheme;
        SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(statusBarColor: Color(0xFFFFFEFE)));
      }

      await _setPreferredTheme(theme);
    } else {
      final brightness = WidgetsBinding.instance.window.platformBrightness;

      if (brightness == Brightness.dark) {
        appTheme = darkTheme;

        await _setPreferredTheme(Themes.dark);
        SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(statusBarColor: Colors.black));
      } else {
        appTheme = lightTheme;
        await _setPreferredTheme(Themes.light);
        SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(statusBarColor: Color(0xFFFFFEFE)));
      }
    }
  }
}
