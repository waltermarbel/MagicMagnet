import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../entities/usecase_entity.dart';
import '../repositories/enable_usecase_repository.dart';

class EnableUsecase
    implements
        AsyncUsecase<Usecase<Stream<MagnetLink>, SearchParameters>,
            UsecaseEntity> {
  final EnableUsecaseRepository repository;

  EnableUsecase(this.repository);

  @override
  Future<Either<Failure, Usecase<Stream<MagnetLink>, SearchParameters>>> call(
      UsecaseEntity usecaseEntity) async {
    return await repository.enableUsecase(usecaseEntity);
  }
}
