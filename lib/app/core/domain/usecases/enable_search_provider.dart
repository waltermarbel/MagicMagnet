import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../entities/search_provider.dart';
import '../repositories/search_providers_repository.dart';

class EnableSearchProvider
    implements
        AsyncUsecase<Usecase<Stream<MagnetLink>, SearchParameters>,
            SearchProvider> {
  final SearchProvidersRepository repository;

  EnableSearchProvider(this.repository);

  @override
  Future<Either<Failure, Usecase<Stream<MagnetLink>, SearchParameters>>> call(
      SearchProvider searchProvider) async {
    return await repository.enableSearchProvider(searchProvider);
  }
}
