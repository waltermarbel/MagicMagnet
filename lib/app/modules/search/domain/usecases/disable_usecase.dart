import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:magicmagnet/app/modules/search/domain/repositories/disable_usecase_repository.dart';

import '../entities/usecase_entity.dart';

class DisableUsecase implements AsyncUsecase<void, UsecaseEntity> {
  final DisableUsecaseRepository repository;

  DisableUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UsecaseEntity usecaseEntity) async {
    return await repository.disableUsecase(usecaseEntity);
  }
}
