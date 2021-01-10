import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

import '../error/exceptions.dart';
import '../infrastructure/datasources/themes_datasource.dart';
import '../utils/user_interface/themes.dart';

class ThemesDataSourceImplementation implements ThemesDataSource {
  SharedPreferencesWindows sharedPreferencesWindows;
  SharedPreferences sharedPreferences;

  ThemesDataSourceImplementation() {
    _getInstances();
  }

  Future<void> _getInstances() async {
    sharedPreferencesWindows = SharedPreferencesWindows();
  }

  @override
  Future<Themes> getPreferredTheme() async {
    if (Platform.isWindows) {
      final prefs = await sharedPreferencesWindows.getAll();

      if (!prefs.containsKey('Preferred Theme')) {
        await sharedPreferencesWindows.setValue(
            'String', 'Preferred Theme', 'Light');
      } else {
        if (prefs['Preferred Theme'] == 'Light') {
          return Themes.light;
        } else {
          return Themes.dark;
        }
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      sharedPreferences = await SharedPreferences.getInstance();

      if (!sharedPreferences.containsKey('Preferred Theme')) {
        await sharedPreferences.setString('Preferred Theme', 'Light');
      } else {
        if (sharedPreferences.getString('Preferred Theme') == 'Light') {
          return Themes.light;
        } else {
          return Themes.dark;
        }
      }
    } else {
      throw UnsupportedPlatformException();
    }
  }

  @override
  Future<void> setPreferredTheme(Themes newPreferredTheme) async {
    if (newPreferredTheme == Themes.light) {
      if (Platform.isWindows) {
        final prefs = await sharedPreferencesWindows.getAll();

        await sharedPreferencesWindows.setValue(
          'String',
          'Preferred Theme',
          'Light',
        );
      } else if (Platform.isAndroid || Platform.isIOS) {
        sharedPreferences = await SharedPreferences.getInstance();

        await sharedPreferences.setString('Preferred Theme', 'Light');
      }
    } else if (newPreferredTheme == Themes.dark) {
      if (Platform.isWindows) {
        final prefs = await sharedPreferencesWindows.getAll();

        await sharedPreferencesWindows.setValue(
          'String',
          'Preferred Theme',
          'Dark',
        );
      } else if (Platform.isAndroid || Platform.isIOS) {
        sharedPreferences = await SharedPreferences.getInstance();

        await sharedPreferences.setString('Preferred Theme', 'Dark');
      }
    } else {
      throw UnsupportedPlatformException();
    }
  }
}
