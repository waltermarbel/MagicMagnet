import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../entities/search_provider.dart';

abstract class SearchProvidersRepository {
  Future<Either<Failure, List<Usecase<Stream<MagnetLink>, SearchParameters>>>>
      getEnabledSearchProviders();

  Future<Either<Failure, Usecase<Stream<MagnetLink>, SearchParameters>>>
      enableSearchProvider(SearchProvider searchProvider);

  Future<Either<Failure, void>> disableSearchProvider(
      SearchProvider searchProvider);
}
