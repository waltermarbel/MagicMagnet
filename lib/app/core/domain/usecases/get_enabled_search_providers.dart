import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../repositories/search_providers_repository.dart';

class GetEnabledSearchProviders
    implements
        AsyncUsecase<List<Usecase<Stream<MagnetLink>, SearchParameters>>,
            NoParams> {
  final SearchProvidersRepository repository;

  GetEnabledSearchProviders(this.repository);

  @override
  Future<Either<Failure, List<Usecase<Stream<MagnetLink>, SearchParameters>>>>
      call(NoParams params) async {
    return await repository.getEnabledSearchProviders();
  }
}
