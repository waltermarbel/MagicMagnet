import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../entities/search_provider.dart';
import '../repositories/search_providers_repository.dart';

class DisableSearchProvider implements AsyncUsecase<void, SearchProvider> {
  final SearchProvidersRepository repository;

  DisableSearchProvider(this.repository);

  @override
  Future<Either<Failure, void>> call(SearchProvider searchProvider) async {
    return await repository.disableSearchProvider(searchProvider);
  }
}
