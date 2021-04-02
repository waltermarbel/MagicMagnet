import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../repositories/trackers_repository.dart';

class DeleteAllCustomTrackers implements AsyncUsecase<void, NoParams> {
  final TrackersRepository repository;

  DeleteAllCustomTrackers(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.deleteAllCustomTrackers();
  }
}
