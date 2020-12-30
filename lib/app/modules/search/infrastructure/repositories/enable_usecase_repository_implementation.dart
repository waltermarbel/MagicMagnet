import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import '../../domain/entities/usecase_entity.dart';
import '../../domain/repositories/enable_usecase_repository.dart';
import '../datasources/usecases_datasource.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class EnableUsecaseRepositoryImplementation implements EnableUsecaseRepository {
  final UsecasesDataSource dataSource;

  EnableUsecaseRepositoryImplementation(this.dataSource);

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
}
