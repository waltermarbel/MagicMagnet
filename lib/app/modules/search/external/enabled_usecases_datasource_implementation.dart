import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

import '../../../core/error/exceptions.dart';
import '../infrastructure/datasources/enabled_usecases_datasource.dart';

class EnabledUsecasesDataSourceImplementation
    implements EnabledUsecasesDataSource {
  final SharedPreferencesWindows sharedPreferencesWindows;

  EnabledUsecasesDataSourceImplementation(this.sharedPreferencesWindows);

  @override
  Future<List<Object>> getEnabledUsecases() async {
    if (Platform.isWindows) {
      var enabledUsecases = [];

      final dataSources = ['google', 'tpb', '1337x', 'nyaa', 'eztv', 'yts'];

      final prefs = await sharedPreferencesWindows.getAll();

      for (var dataSource in dataSources) {
        if (!prefs.containsKey(dataSource)) {
          sharedPreferencesWindows.setValue('Bool', dataSource, true);
        }
      }

      if (prefs['google']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromGoogle>());
      }

      if (prefs['tpb']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromTPB>());
      }

      if (prefs['1337x']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFrom1337X>());
      }

      if (prefs['nyaa']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromNyaa>());
      }

      if (prefs['eztv']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromEZTV>());
      }

      if (prefs['yts']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromYTS>());
      }

      return enabledUsecases;
    } else {
      throw UnsupportedPlatformException();
    }
  }
}
