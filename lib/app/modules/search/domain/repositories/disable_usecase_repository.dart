import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../entities/usecase_entity.dart';

abstract class DisableUsecaseRepository {
  Future<Either<Failure, void>> disableUsecase(UsecaseEntity usecaseEntity);
}
