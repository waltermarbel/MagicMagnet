import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../domain/repositories/trackers_repository.dart';
import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../datasources/trackers_datasource.dart';

class TrackersRepositoryImplementation implements TrackersRepository {
  final TrackersDataSource dataSource;

  TrackersRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, List<Tracker>>> getTrackers() async {
    try {
      final usecases = await dataSource.getTrackers();
      return right(usecases);
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }
}
