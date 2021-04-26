import 'dart:io';

import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

import '../domain/entities/search_provider.dart';
import '../error/exceptions.dart';
import '../infrastructure/datasources/search_providers_datasource.dart';

class SearchProvidersDataSourceImplementation
    implements SearchProvidersDataSource {
  final HttpClient httpClient;
  SharedPreferencesWindows sharedPreferencesWindows;
  SharedPreferences sharedPreferences;

  SearchProvidersDataSourceImplementation(this.httpClient) {
    _getInstances();
  }

  Future<void> _getInstances() async {
    sharedPreferencesWindows = SharedPreferencesWindows();
  }

  @override
  Future<List<Usecase<Stream<MagnetLink>, SearchParameters>>>
      getEnabledSearchProviders() async {
    final enabledSearchProviders =
        <Usecase<Stream<MagnetLink>, SearchParameters>>[];

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

      if (!prefs.containsKey('Google')) {
        sharedPreferencesWindows.setValue('Bool', 'Google', true);
      }

      for (var dataSource in dataSources.sublist(1)) {
        if (!prefs.containsKey(dataSource)) {
          sharedPreferencesWindows.setValue('Bool', dataSource, false);
        }
      }

      if (prefs['Google']) {
        final dataSource = GoogleDataSourceImplementation(httpClient);
        final repository = GoogleRepositoryImplementation(dataSource);
        enabledSearchProviders.add(GetMagnetLinksFromGoogle(repository));
      }

      if (prefs['The Pirate Bay']) {
        final dataSource = TPBDataSourceImplementation(httpClient);
        final repository = TPBRepositoryImplementation(dataSource);
        enabledSearchProviders.add(GetMagnetLinksFromTPB(repository));
      }

      if (prefs['1337x']) {
        final dataSource = I337XDataSourceImplementation(httpClient);
        final repository = I337XRepositoryImplementation(dataSource);
        enabledSearchProviders.add(GetMagnetLinksFrom1337X(repository));
      }

      if (prefs['Nyaa']) {
        final dataSource = NyaaDataSourceImplementation(httpClient);
        final repository = NyaaRepositoryImplementation(dataSource);
        enabledSearchProviders.add(GetMagnetLinksFromNyaa(repository));
      }

      if (prefs['EZTV']) {
        final dataSource = EZTVDataSourceImplementation(httpClient);
        final repository = EZTVRepositoryImplementation(dataSource);
        enabledSearchProviders.add(GetMagnetLinksFromEZTV(repository));
      }

      if (prefs['YTS']) {
        final dataSource = YTSDataSourceImplementation(httpClient);
        final repository = YTSRepositoryImplementation(dataSource);
        enabledSearchProviders.add(GetMagnetLinksFromYTS(repository));
      }

      if (prefs['LimeTorrents']) {
        final dataSource = LimeTorrentsDataSourceImplementation(httpClient);
        final repository = LimeTorrentsRepositoryImplementation(dataSource);
        enabledSearchProviders.add(GetMagnetLinksFromLimeTorrents(repository));
      }

      return enabledSearchProviders;
    } else if (Platform.isAndroid || Platform.isIOS) {
      sharedPreferences = await SharedPreferences.getInstance();

      if (!sharedPreferences.containsKey('Google')) {
        sharedPreferences.setBool('Google', true);
      }

      for (var dataSource in dataSources) {
        if (!sharedPreferences.containsKey(dataSource)) {
          sharedPreferences.setBool(dataSource, false);
        }

        if (sharedPreferences.getBool(dataSource)) {
          if (dataSource == 'Google') {
            final dataSource = GoogleDataSourceImplementation(httpClient);
            final repository = GoogleRepositoryImplementation(dataSource);
            enabledSearchProviders.add(GetMagnetLinksFromGoogle(repository));
          }
          if (dataSource == 'The Pirate Bay') {
            final dataSource = TPBDataSourceImplementation(httpClient);
            final repository = TPBRepositoryImplementation(dataSource);
            enabledSearchProviders.add(GetMagnetLinksFromTPB(repository));
          }
          if (dataSource == '1337x') {
            final dataSource = I337XDataSourceImplementation(httpClient);
            final repository = I337XRepositoryImplementation(dataSource);
            enabledSearchProviders.add(GetMagnetLinksFrom1337X(repository));
          }
          if (dataSource == 'Nyaa') {
            final dataSource = NyaaDataSourceImplementation(httpClient);
            final repository = NyaaRepositoryImplementation(dataSource);
            enabledSearchProviders.add(GetMagnetLinksFromNyaa(repository));
          }
          if (dataSource == 'EZTV') {
            final dataSource = EZTVDataSourceImplementation(httpClient);
            final repository = EZTVRepositoryImplementation(dataSource);
            enabledSearchProviders.add(GetMagnetLinksFromEZTV(repository));
          }
          if (dataSource == 'YTS') {
            final dataSource = YTSDataSourceImplementation(httpClient);
            final repository = YTSRepositoryImplementation(dataSource);
            enabledSearchProviders.add(GetMagnetLinksFromYTS(repository));
          }
          if (dataSource == 'LimeTorrents') {
            final dataSource = LimeTorrentsDataSourceImplementation(httpClient);
            final repository = LimeTorrentsRepositoryImplementation(dataSource);
            enabledSearchProviders
                .add(GetMagnetLinksFromLimeTorrents(repository));
          }
        }
      }

      return enabledSearchProviders;
    } else {
      throw UnsupportedPlatformException();
    }
  }

  @override
  // ignore: missing_return
  Future<Usecase<Stream<MagnetLink>, SearchParameters>> enableSearchProvider(
      SearchProvider searchProvider) async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (searchProvider.key == 'Google') {
        await sharedPreferences.setBool(searchProvider.key, true);

        final dataSource = GoogleDataSourceImplementation(httpClient);
        final repository = GoogleRepositoryImplementation(dataSource);
        return GetMagnetLinksFromGoogle(repository);
      }

      if (searchProvider.key == 'The Pirate Bay') {
        await sharedPreferences.setBool(searchProvider.key, true);

        final dataSource = TPBDataSourceImplementation(httpClient);
        final repository = TPBRepositoryImplementation(dataSource);
        return GetMagnetLinksFromTPB(repository);
      }

      if (searchProvider.key == '1337x') {
        await sharedPreferences.setBool(searchProvider.key, true);

        final dataSource = I337XDataSourceImplementation(httpClient);
        final repository = I337XRepositoryImplementation(dataSource);
        return GetMagnetLinksFrom1337X(repository);
      }

      if (searchProvider.key == 'Nyaa') {
        await sharedPreferences.setBool(searchProvider.key, true);

        final dataSource = NyaaDataSourceImplementation(httpClient);
        final repository = NyaaRepositoryImplementation(dataSource);
        return GetMagnetLinksFromNyaa(repository);
      }

      if (searchProvider.key == 'EZTV') {
        await sharedPreferences.setBool(searchProvider.key, true);

        final dataSource = EZTVDataSourceImplementation(httpClient);
        final repository = EZTVRepositoryImplementation(dataSource);
        return GetMagnetLinksFromEZTV(repository);
      }

      if (searchProvider.key == 'YTS') {
        await sharedPreferences.setBool(searchProvider.key, true);

        final dataSource = YTSDataSourceImplementation(httpClient);
        final repository = YTSRepositoryImplementation(dataSource);
        return GetMagnetLinksFromYTS(repository);
      }

      if (searchProvider.key == 'LimeTorrents') {
        await sharedPreferences.setBool(searchProvider.key, true);

        final dataSource = LimeTorrentsDataSourceImplementation(httpClient);
        final repository = LimeTorrentsRepositoryImplementation(dataSource);
        return GetMagnetLinksFromLimeTorrents(repository);
      }
    } else if (Platform.isWindows) {
      if (searchProvider.key == 'Google') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          searchProvider.key,
          true,
        );

        final dataSource = GoogleDataSourceImplementation(httpClient);
        final repository = GoogleRepositoryImplementation(dataSource);
        return GetMagnetLinksFromGoogle(repository);
      }

      if (searchProvider.key == 'The Pirate Bay') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          searchProvider.key,
          true,
        );
        final dataSource = TPBDataSourceImplementation(httpClient);
        final repository = TPBRepositoryImplementation(dataSource);
        return GetMagnetLinksFromTPB(repository);
      }

      if (searchProvider.key == '1337x') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          searchProvider.key,
          true,
        );

        final dataSource = I337XDataSourceImplementation(httpClient);
        final repository = I337XRepositoryImplementation(dataSource);
        return GetMagnetLinksFrom1337X(repository);
      }

      if (searchProvider.key == 'Nyaa') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          searchProvider.key,
          true,
        );

        final dataSource = NyaaDataSourceImplementation(httpClient);
        final repository = NyaaRepositoryImplementation(dataSource);
        return GetMagnetLinksFromNyaa(repository);
      }

      if (searchProvider.key == 'EZTV') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          searchProvider.key,
          true,
        );

        final dataSource = EZTVDataSourceImplementation(httpClient);
        final repository = EZTVRepositoryImplementation(dataSource);
        return GetMagnetLinksFromEZTV(repository);
      }

      if (searchProvider.key == 'YTS') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          searchProvider.key,
          true,
        );

        final dataSource = YTSDataSourceImplementation(httpClient);
        final repository = YTSRepositoryImplementation(dataSource);
        return GetMagnetLinksFromYTS(repository);
      }

      if (searchProvider.key == 'LimeTorrents') {
        await sharedPreferencesWindows.setValue(
          'Bool',
          searchProvider.key,
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
  Future<void> disableSearchProvider(SearchProvider searchProvider) async {
    if (Platform.isAndroid || Platform.isIOS) {
      await sharedPreferences.setBool(searchProvider.key, false);
    } else if (Platform.isWindows) {
      await sharedPreferencesWindows.setValue(
        'Bool',
        searchProvider.key,
        false,
      );
    } else {
      throw UnsupportedPlatformException();
    }
  }
}
