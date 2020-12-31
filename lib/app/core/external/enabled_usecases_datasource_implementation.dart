import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

import '../domain/entities/usecase_entity.dart';
import '../error/exceptions.dart';
import '../infrastructure/datasources/usecases_datasource.dart';

class UsecasesDataSourceImplementation implements UsecasesDataSource {
  final SharedPreferencesWindows sharedPreferencesWindows;

  UsecasesDataSourceImplementation(this.sharedPreferencesWindows);

  @override
  Future<List<Usecase<Stream<MagnetLink>, SearchParameters>>>
      getEnabledUsecases() async {
    if (Platform.isWindows) {
      var enabledUsecases = <Usecase<Stream<MagnetLink>, SearchParameters>>[];

      final dataSources = [
        'Google',
        'The Pirate Bay',
        '1337x',
        'Nyaa',
        'EZTV',
        'YTS'
      ];

      final prefs = await sharedPreferencesWindows.getAll();

      for (var dataSource in dataSources) {
        if (!prefs.containsKey(dataSource)) {
          sharedPreferencesWindows.setValue('Bool', dataSource, true);
        }
      }

      if (prefs['Google']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromGoogle>());
      }

      if (prefs['The Pirate Bay']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromTPB>());
      }

      if (prefs['1337x']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFrom1337X>());
      }

      if (prefs['Nyaa']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromNyaa>());
      }

      if (prefs['EZTV']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromEZTV>());
      }

      if (prefs['YTS']) {
        enabledUsecases.add(Modular.get<GetMagnetLinksFromYTS>());
      }

      return enabledUsecases;
    } else {
      throw UnsupportedPlatformException();
    }
  }

  @override
  Future<Usecase<Stream<MagnetLink>, SearchParameters>> enableUsecase(
      UsecaseEntity usecaseEntity) async {
    if (Platform.isWindows) {
      if (usecaseEntity.key == 'Google') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        return Modular.get<GetMagnetLinksFromGoogle>();
      }

      if (usecaseEntity.key == 'The Pirate Bay') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        return Modular.get<GetMagnetLinksFromTPB>();
      }

      if (usecaseEntity.key == '1337x') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        return Modular.get<GetMagnetLinksFrom1337X>();
      }

      if (usecaseEntity.key == 'Nyaa') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        return Modular.get<GetMagnetLinksFromNyaa>();
      }

      if (usecaseEntity.key == 'EZTV') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        return Modular.get<GetMagnetLinksFromEZTV>();
      }

      if (usecaseEntity.key == 'Nyaa') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        return Modular.get<GetMagnetLinksFromYTS>();
      }
    } else {
      throw UnsupportedPlatformException();
    }
  }

  @override
  Future<void> disableUsecase(UsecaseEntity usecaseEntity) async {
    await sharedPreferencesWindows.setValue(
      'Bool',
      usecaseEntity.key,
      false,
    );
  }
}
