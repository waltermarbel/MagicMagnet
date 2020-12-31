import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../domain/entities/usecase_entity.dart';
import '../../domain/repositories/disable_usecase_repository.dart';
import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../datasources/usecases_datasource.dart';

class DisableUsecaseRepositoryImplementation
    implements DisableUsecaseRepository {
  final UsecasesDataSource dataSource;

  DisableUsecaseRepositoryImplementation(this.dataSource);

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
