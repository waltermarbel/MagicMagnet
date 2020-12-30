import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/enabled_usecases_repository.dart';
import '../datasources/enabled_usecases_datasource.dart';

class EnabledUsecasesRepositoryImplementation
    implements EnabledUsecasesRepository {
  final EnabledUsecasesDataSource dataSource;

  EnabledUsecasesRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, List<Object>>> getEnabledUsecases() async {
    try {
      final usecases = await dataSource.getEnabledUsecases();
      return right(usecases);
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }
}
