import 'dart:io';

import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

import '../domain/entities/usecase_entity.dart';
import '../error/exceptions.dart';
import '../infrastructure/datasources/usecases_datasource.dart';

class UsecasesDataSourceImplementation implements UsecasesDataSource {
  final HttpClient httpClient;
  SharedPreferencesWindows sharedPreferencesWindows;
  SharedPreferences sharedPreferences;

  UsecasesDataSourceImplementation(this.httpClient) {
    _getInstances();
  }

  Future<void> _getInstances() async {
    sharedPreferencesWindows = SharedPreferencesWindows();
  }

  @override
  Future<List<Usecase<Stream<MagnetLink>, SearchParameters>>>
      getEnabledUsecases() async {
    var enabledUsecases = <Usecase<Stream<MagnetLink>, SearchParameters>>[];

    final dataSources = [
      'Google',
      'The Pirate Bay',
      '1337x',
      'Nyaa',
      'EZTV',
      'YTS',
      'LimeTorrents'
    ];

    if (Platform.isWindows) {
      final prefs = await sharedPreferencesWindows.getAll();

      for (var dataSource in dataSources) {
        if (!prefs.containsKey(dataSource)) {
          sharedPreferencesWindows.setValue('Bool', dataSource, true);
        }
      }

      if (prefs['Google']) {
        final dataSource = GoogleDataSourceImplementation(httpClient);
        final repository = GoogleRepositoryImplementation(dataSource);
        enabledUsecases.add(GetMagnetLinksFromGoogle(repository));
      }

      if (prefs['The Pirate Bay']) {
        final dataSource = TPBDataSourceImplementation(httpClient);
        final repository = TPBRepositoryImplementation(dataSource);
        enabledUsecases.add(GetMagnetLinksFromTPB(repository));
      }

      if (prefs['1337x']) {
        final dataSource = I337XDataSourceImplementation(httpClient);
        final repository = I337XRepositoryImplementation(dataSource);
        enabledUsecases.add(GetMagnetLinksFrom1337X(repository));
      }

      if (prefs['Nyaa']) {
        final dataSource = NyaaDataSourceImplementation(httpClient);
        final repository = NyaaRepositoryImplementation(dataSource);
        enabledUsecases.add(GetMagnetLinksFromNyaa(repository));
      }

      if (prefs['EZTV']) {
        final dataSource = EZTVDataSourceImplementation(httpClient);
        final repository = EZTVRepositoryImplementation(dataSource);
        enabledUsecases.add(GetMagnetLinksFromEZTV(repository));
      }

      if (prefs['YTS']) {
        final dataSource = YTSDataSourceImplementation(httpClient);
        final repository = YTSRepositoryImplementation(dataSource);
        enabledUsecases.add(GetMagnetLinksFromYTS(repository));
      }

      if (prefs['LimeTorrents']) {
        final dataSource = LimeTorrentsDataSourceImplementation(httpClient);
        final repository = LimeTorrentsRepositoryImplementation(dataSource);
        enabledUsecases.add(GetMagnetLinksFromLimeTorrents(repository));
      }

      return enabledUsecases;
    } else if (Platform.isAndroid || Platform.isIOS) {
      sharedPreferences = await SharedPreferences.getInstance();
      for (var dataSource in dataSources) {
        if (!sharedPreferences.containsKey(dataSource)) {
          sharedPreferences.setBool(dataSource, true);
        }

        if (sharedPreferences.getBool(dataSource)) {
          if (dataSource == 'Google') {
            final dataSource = GoogleDataSourceImplementation(httpClient);
            final repository = GoogleRepositoryImplementation(dataSource);
            enabledUsecases.add(GetMagnetLinksFromGoogle(repository));
          }
          if (dataSource == 'The Pirate Bay') {
            final dataSource = TPBDataSourceImplementation(httpClient);
            final repository = TPBRepositoryImplementation(dataSource);
            enabledUsecases.add(GetMagnetLinksFromTPB(repository));
          }
          if (dataSource == '1337x') {
            final dataSource = I337XDataSourceImplementation(httpClient);
            final repository = I337XRepositoryImplementation(dataSource);
            enabledUsecases.add(GetMagnetLinksFrom1337X(repository));
          }
          if (dataSource == 'Nyaa') {
            final dataSource = NyaaDataSourceImplementation(httpClient);
            final repository = NyaaRepositoryImplementation(dataSource);
            enabledUsecases.add(GetMagnetLinksFromNyaa(repository));
          }
          if (dataSource == 'EZTV') {
            final dataSource = EZTVDataSourceImplementation(httpClient);
            final repository = EZTVRepositoryImplementation(dataSource);
            enabledUsecases.add(GetMagnetLinksFromEZTV(repository));
          }
          if (dataSource == 'YTS') {
            final dataSource = YTSDataSourceImplementation(httpClient);
            final repository = YTSRepositoryImplementation(dataSource);
            enabledUsecases.add(GetMagnetLinksFromYTS(repository));
          }
          if (dataSource == 'LimeTorrents') {
            final dataSource = LimeTorrentsDataSourceImplementation(httpClient);
            final repository = LimeTorrentsRepositoryImplementation(dataSource);
            enabledUsecases.add(GetMagnetLinksFromLimeTorrents(repository));
          }
        }
      }

      return enabledUsecases;
    } else {
      throw UnsupportedPlatformException();
    }
  }

  @override
  // ignore: missing_return
  Future<Usecase<Stream<MagnetLink>, SearchParameters>> enableUsecase(
      UsecaseEntity usecaseEntity) async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (usecaseEntity.key == 'Google') {
        await sharedPreferences.setBool(usecaseEntity.key, true);

        final dataSource = GoogleDataSourceImplementation(httpClient);
        final repository = GoogleRepositoryImplementation(dataSource);
        return GetMagnetLinksFromGoogle(repository);
      }

      if (usecaseEntity.key == 'The Pirate Bay') {
        await sharedPreferences.setBool(usecaseEntity.key, true);

        final dataSource = TPBDataSourceImplementation(httpClient);
        final repository = TPBRepositoryImplementation(dataSource);
        return GetMagnetLinksFromTPB(repository);
      }

      if (usecaseEntity.key == '1337x') {
        await sharedPreferences.setBool(usecaseEntity.key, true);

        final dataSource = I337XDataSourceImplementation(httpClient);
        final repository = I337XRepositoryImplementation(dataSource);
        return GetMagnetLinksFrom1337X(repository);
      }

      if (usecaseEntity.key == 'Nyaa') {
        await sharedPreferences.setBool(usecaseEntity.key, true);

        final dataSource = NyaaDataSourceImplementation(httpClient);
        final repository = NyaaRepositoryImplementation(dataSource);
        return GetMagnetLinksFromNyaa(repository);
      }

      if (usecaseEntity.key == 'EZTV') {
        await sharedPreferences.setBool(usecaseEntity.key, true);

        final dataSource = EZTVDataSourceImplementation(httpClient);
        final repository = EZTVRepositoryImplementation(dataSource);
        return GetMagnetLinksFromEZTV(repository);
      }

      if (usecaseEntity.key == 'YTS') {
        await sharedPreferences.setBool(usecaseEntity.key, true);

        final dataSource = YTSDataSourceImplementation(httpClient);
        final repository = YTSRepositoryImplementation(dataSource);
        return GetMagnetLinksFromYTS(repository);
      }

      if (usecaseEntity.key == 'LimeTorrents') {
        await sharedPreferences.setBool(usecaseEntity.key, true);

        final dataSource = LimeTorrentsDataSourceImplementation(httpClient);
        final repository = LimeTorrentsRepositoryImplementation(dataSource);
        return GetMagnetLinksFromLimeTorrents(repository);
      }
    } else if (Platform.isWindows) {
      if (usecaseEntity.key == 'Google') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        final dataSource = GoogleDataSourceImplementation(httpClient);
        final repository = GoogleRepositoryImplementation(dataSource);
        return GetMagnetLinksFromGoogle(repository);
      }

      if (usecaseEntity.key == 'The Pirate Bay') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );
        final dataSource = TPBDataSourceImplementation(httpClient);
        final repository = TPBRepositoryImplementation(dataSource);
        return GetMagnetLinksFromTPB(repository);
      }

      if (usecaseEntity.key == '1337x') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        final dataSource = I337XDataSourceImplementation(httpClient);
        final repository = I337XRepositoryImplementation(dataSource);
        return GetMagnetLinksFrom1337X(repository);
      }

      if (usecaseEntity.key == 'Nyaa') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        final dataSource = NyaaDataSourceImplementation(httpClient);
        final repository = NyaaRepositoryImplementation(dataSource);
        return GetMagnetLinksFromNyaa(repository);
      }

      if (usecaseEntity.key == 'EZTV') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        final dataSource = EZTVDataSourceImplementation(httpClient);
        final repository = EZTVRepositoryImplementation(dataSource);
        return GetMagnetLinksFromEZTV(repository);
      }

      if (usecaseEntity.key == 'YTS') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        final dataSource = YTSDataSourceImplementation(httpClient);
        final repository = YTSRepositoryImplementation(dataSource);
        return GetMagnetLinksFromYTS(repository);
      }

      if (usecaseEntity.key == 'LimeTorrents') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          usecaseEntity.key,
          true,
        );

        final dataSource = LimeTorrentsDataSourceImplementation(httpClient);
        final repository = LimeTorrentsRepositoryImplementation(dataSource);
        return GetMagnetLinksFromLimeTorrents(repository);
      }
    } else {
      throw UnsupportedPlatformException();
    }
  }

  @override
  Future<void> disableUsecase(UsecaseEntity usecaseEntity) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await sharedPreferences.setBool(usecaseEntity.key, false);
    } else if (Platform.isWindows) {
      await sharedPreferencesWindows.setValue(
        'Bool',
        usecaseEntity.key,
        false,
      );
    } else {
      throw UnsupportedPlatformException();
    }
  }
}
