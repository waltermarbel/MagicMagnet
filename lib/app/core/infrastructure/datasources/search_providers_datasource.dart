import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../domain/entities/search_provider.dart';

abstract class SearchProvidersDataSource {
  Future<List<Usecase<Stream<MagnetLink>, SearchParameters>>>
      getEnabledSearchProviders();

  Future<Usecase<Stream<MagnetLink>, SearchParameters>> enableSearchProvider(
      SearchProvider searchProvider);

  Future<void> disableSearchProvider(SearchProvider searchProvider);
}
