import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

abstract class EnabledUsecasesRepository {
  Future<Either<Failure, List<Usecase<Stream<MagnetLink>, SearchParameters>>>>
      getEnabledUsecases();
}
