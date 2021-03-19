import 'package:magic_magnet_engine/magic_magnet_engine.dart';

abstract class TrackersDataSource {
  Future<List<Tracker>> getTrackers();
}
