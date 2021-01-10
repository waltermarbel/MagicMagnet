import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../domain/entities/usecase_entity.dart';
import '../../domain/repositories/usecases_repository.dart';
import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../datasources/usecases_datasource.dart';

class UsecasesRepositoryImplementation implements UsecasesRepository {
  final UsecasesDataSource dataSource;

  UsecasesRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, List<Usecase<Stream<MagnetLink>, SearchParameters>>>>
      getEnabledUsecases() async {
    try {
      final usecases = await dataSource.getEnabledUsecases();
      return right(usecases);
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }

  @override
  Future<Either<Failure, Usecase<Stream<MagnetLink>, SearchParameters>>>
      enableUsecase(UsecaseEntity usecaseEntity) async {
    try {
      final usecase = await dataSource.enableUsecase(usecaseEntity);
      return right(usecase);
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }

  @override
  Future<Either<Failure, void>> disableUsecase(
      UsecaseEntity usecaseEntity) async {
    try {
      return right(await dataSource.disableUsecase(usecaseEntity));
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }
}
