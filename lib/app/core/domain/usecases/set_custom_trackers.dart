import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../repositories/trackers_repository.dart';

class SetCustomTrackers implements AsyncUsecase<void, CustomTrackersParams> {
  final TrackersRepository repository;

  SetCustomTrackers(this.repository);

  @override
  Future<Either<Failure, void>> call(
    CustomTrackersParams params,
  ) async {
    return await repository.setCustomTrackers(params.customTrackers);
  }
}

class CustomTrackersParams {
  final List<String> customTrackers;

  CustomTrackersParams(this.customTrackers);
}
