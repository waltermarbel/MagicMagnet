import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../domain/entities/search_provider.dart';
import '../../domain/repositories/search_providers_repository.dart';
import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../datasources/search_providers_datasource.dart';

class SearchProvidersRepositoryImplementation
    implements SearchProvidersRepository {
  final SearchProvidersDataSource dataSource;

  SearchProvidersRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, List<Usecase<Stream<MagnetLink>, SearchParameters>>>>
      getEnabledSearchProviders() async {
    try {
      final searchProviders = await dataSource.getEnabledSearchProviders();
      return right(searchProviders);
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }

  @override
  Future<Either<Failure, Usecase<Stream<MagnetLink>, SearchParameters>>>
      enableSearchProvider(SearchProvider searchProvider) async {
    try {
      final enabledSearchProvider =
          await dataSource.enableSearchProvider(searchProvider);
      return right(enabledSearchProvider);
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }

  @override
  Future<Either<Failure, void>> disableSearchProvider(
      SearchProvider searchProvider) async {
    try {
      return right(await dataSource.disableSearchProvider(searchProvider));
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }
}
