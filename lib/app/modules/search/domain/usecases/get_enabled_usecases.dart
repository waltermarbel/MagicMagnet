import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../repositories/enabled_usecases_repository.dart';

class GetEnabledUsecases implements AsyncUsecase<List<Object>, NoParams> {
  final EnabledUsecasesRepository repository;

  GetEnabledUsecases(this.repository);

  @override
  Future<Either<Failure, List<Object>>> call(NoParams params) async {
    return await repository.getEnabledUsecases();
  }
}
