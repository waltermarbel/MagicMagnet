import 'dart:io';

import 'package:hive/hive.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:path_provider/path_provider.dart' as path;

import '../domain/entities/search_provider.dart';
import '../infrastructure/datasources/search_providers_datasource.dart';

class SearchProvidersDataSourceImplementation
    implements SearchProvidersDataSource {
  final HttpClient httpClient;

  SearchProvidersDataSourceImplementation(this.httpClient) {
    _initialSetup();
  }

  Future<void> _initialSetup() async {
    final applicationDocumentsDirectory =
        await path.getApplicationDocumentsDirectory();

    Hive.init(applicationDocumentsDirectory.path);
  }

  @override
  Future<List<Usecase<Stream<MagnetLink>, SearchParameters>>>
      getEnabledSearchProviders() async {
    final enabledSearchProviders =
        <Usecase<Stream<MagnetLink>, SearchParameters>>[];

    final searchProvidersBox = await Hive.boxExists('SearchProviders')
        ? Hive.box('SearchProviders')
        : await Hive.openBox('SearchProviders');

    final dataSources = [
      'Google',
      'The Pirate Bay',
      '1337x',
      'Nyaa',
      'EZTV',
      'YTS',
      'LimeTorrents'
    ];

    for (var dataSource in dataSources) {
      if (!searchProvidersBox.containsKey(dataSource)) {
        searchProvidersBox.put(dataSource, true);
      }

      if (searchProvidersBox.get(dataSource)) {
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
  }

  @override
  // ignore: missing_return
  Future<Usecase<Stream<MagnetLink>, SearchParameters>> enableSearchProvider(
      SearchProvider searchProvider) async {
    final searchProvidersBox = await Hive.boxExists('SearchProviders')
        ? Hive.box('SearchProviders')
        : await Hive.openBox('SearchProviders');

    if (searchProvider.key == 'Google') {
      await searchProvidersBox.put(searchProvider.key, true);

      final dataSource = GoogleDataSourceImplementation(httpClient);
      final repository = GoogleRepositoryImplementation(dataSource);
      return GetMagnetLinksFromGoogle(repository);
    }

    if (searchProvider.key == 'The Pirate Bay') {
      await searchProvidersBox.put(searchProvider.key, true);

      final dataSource = TPBDataSourceImplementation(httpClient);
      final repository = TPBRepositoryImplementation(dataSource);
      return GetMagnetLinksFromTPB(repository);
    }

    if (searchProvider.key == '1337x') {
      await searchProvidersBox.put(searchProvider.key, true);

      final dataSource = I337XDataSourceImplementation(httpClient);
      final repository = I337XRepositoryImplementation(dataSource);
      return GetMagnetLinksFrom1337X(repository);
    }

    if (searchProvider.key == 'Nyaa') {
      await searchProvidersBox.put(searchProvider.key, true);

      final dataSource = NyaaDataSourceImplementation(httpClient);
      final repository = NyaaRepositoryImplementation(dataSource);
      return GetMagnetLinksFromNyaa(repository);
    }

    if (searchProvider.key == 'EZTV') {
      await searchProvidersBox.put(searchProvider.key, true);

      final dataSource = EZTVDataSourceImplementation(httpClient);
      final repository = EZTVRepositoryImplementation(dataSource);
      return GetMagnetLinksFromEZTV(repository);
    }

    if (searchProvider.key == 'YTS') {
      await searchProvidersBox.put(searchProvider.key, true);

      final dataSource = YTSDataSourceImplementation(httpClient);
      final repository = YTSRepositoryImplementation(dataSource);
      return GetMagnetLinksFromYTS(repository);
    }

    if (searchProvider.key == 'LimeTorrents') {
      await searchProvidersBox.put(searchProvider.key, true);

      final dataSource = LimeTorrentsDataSourceImplementation(httpClient);
      final repository = LimeTorrentsRepositoryImplementation(dataSource);
      return GetMagnetLinksFromLimeTorrents(repository);
    }
  }

  @override
  Future<void> disableSearchProvider(SearchProvider searchProvider) async {
    final searchProvidersBox = await Hive.boxExists('SearchProviders')
        ? Hive.box('SearchProviders')
        : await Hive.openBox('SearchProviders');

    // ignore: cascade_invocations
    searchProvidersBox.put(searchProvider.key, false);
  }
}
