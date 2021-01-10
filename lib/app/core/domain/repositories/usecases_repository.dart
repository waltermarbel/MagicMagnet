import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../entities/usecase_entity.dart';

abstract class UsecasesRepository {
  Future<Either<Failure, List<Usecase<Stream<MagnetLink>, SearchParameters>>>>
      getEnabledUsecases();

  Future<Either<Failure, Usecase<Stream<MagnetLink>, SearchParameters>>>
      enableUsecase(UsecaseEntity usecaseEntity);

  Future<Either<Failure, void>> disableUsecase(UsecaseEntity usecaseEntity);
}
