import 'dart:io';

import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';

import '../infrastructure/datasources/trackers_datasource.dart';

class TrackersDataSourceImplementation implements TrackersDataSource {
  final HttpClient httpClient;
  final GetTrackersFromGitHub getTrackersFromGitHub;
  SharedPreferencesWindows sharedPreferencesWindows;
  SharedPreferences sharedPreferences;

  TrackersDataSourceImplementation(
    this.httpClient,
    this.getTrackersFromGitHub,
  ) {
    _getInstances();
    getTrackers();
  }

  Future<void> _getInstances() async {
    sharedPreferencesWindows = SharedPreferencesWindows();
  }

  @override
  Future<List<Tracker>> getTrackers() async {
    List<Tracker> trackers = [];

    if (Platform.isAndroid || Platform.isIOS) {
      sharedPreferences = await SharedPreferences.getInstance();

      if (!sharedPreferences.containsKey('Custom trackers') ||
          sharedPreferences.getStringList('Custom trackers').isEmpty) {
        if (!sharedPreferences.containsKey('Last Update') ||
            DateTime.parse(sharedPreferences.getString('Last Update')).difference(DateTime.now()).inHours > 24) {
          final result = await getTrackersFromGitHub(NoParams());

          result.fold(
            (error) => throw Exception(),
            (success) async {
              trackers = success;

              await sharedPreferences.setStringList(
                'GitHub trackers',
                success.map<String>((tracker) => tracker.toString()).toList(),
              );
            },
          );

          sharedPreferences.setString('Last Update', DateTime.now().toString());
        } else {
          trackers = sharedPreferences
              .getStringList('GitHub trackers')
              .map<Tracker>((tracker) => TrackerModel.fromString(tracker))
              .toList();
        }
      } else {
        trackers = await getCustomTrackers();
      }
    }

    return trackers;
  }

  @override
  Future<void> setCustomTrackers(List<String> customTrackers) async {
    if (Platform.isAndroid || Platform.isIOS) {
      sharedPreferences = await SharedPreferences.getInstance();

      await sharedPreferences.setStringList('Custom trackers', customTrackers);
    }
  }

  @override
  Future<List<Tracker>> getCustomTrackers() async {
    List<Tracker> trackers = [];

    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey('Custom trackers')) {
      trackers = sharedPreferences
          .getStringList('Custom trackers')
          .map<Tracker>((tracker) => TrackerModel.fromString(tracker))
          .toList();
    }

    return trackers;
  }

  @override
  Future<void> deleteAllCustomTrackers() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey('Custom trackers')) {
      sharedPreferences.remove('Custom trackers');
    }
  }
}
