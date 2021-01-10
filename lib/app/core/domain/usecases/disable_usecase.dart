import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../entities/usecase_entity.dart';
import '../repositories/usecases_repository.dart';

class DisableUsecase implements AsyncUsecase<void, UsecaseEntity> {
  final UsecasesRepository repository;

  DisableUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UsecaseEntity usecaseEntity) async {
    return await repository.disableUsecase(usecaseEntity);
  }
}
