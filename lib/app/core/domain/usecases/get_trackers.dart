import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../repositories/trackers_repository.dart';

class GetTrackers implements AsyncUsecase<List<Tracker>, NoParams> {
  final TrackersRepository repository;

  GetTrackers(this.repository);

  @override
  Future<Either<Failure, List<Tracker>>> call(NoParams params) async {
    return await repository.getTrackers();
  }
}
