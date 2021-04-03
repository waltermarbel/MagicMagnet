import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

abstract class TrackersRepository {
  Future<Either<Failure, List<Tracker>>> getTrackers();
  Future<Either<Failure, List<Tracker>>> getCustomTrackers();
  Future<Either<Failure, void>> setCustomTrackers(List<String> customTrackers);
  Future<Either<Failure, void>> deleteAllCustomTrackers();
}
