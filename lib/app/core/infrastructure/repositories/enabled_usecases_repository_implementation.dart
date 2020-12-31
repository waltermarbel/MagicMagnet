import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../domain/repositories/enabled_usecases_repository.dart';
import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../datasources/usecases_datasource.dart';

class EnabledUsecasesRepositoryImplementation
    implements EnabledUsecasesRepository {
  final UsecasesDataSource dataSource;

  EnabledUsecasesRepositoryImplementation(this.dataSource);

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
}
