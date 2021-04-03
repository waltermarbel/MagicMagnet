import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/domain/entities/search_provider.dart';
import '../../../../core/domain/usecases/delete_all_custom_trackers.dart';
import '../../../../core/domain/usecases/disable_search_provider.dart';
import '../../../../core/domain/usecases/enable_search_provider.dart';
import '../../../../core/domain/usecases/get_custom_trackers.dart';
import '../../../../core/domain/usecases/get_enabled_search_providers.dart';
import '../../../../core/domain/usecases/set_custom_trackers.dart';

part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  final GetEnabledSearchProviders _getEnabledSearchProviders;
  final EnableSearchProvider _enableSearchProvider;
  final DisableSearchProvider _disableSearchProvider;
  final SetCustomTrackers _setCustomTrackers;
  final GetCustomTrackers _getCustomTrackers;
  final DeleteAllCustomTrackers _deleteAllCustomTrackers;

  _SettingsControllerBase(
    this._getEnabledSearchProviders,
    this._enableSearchProvider,
    this._disableSearchProvider,
    this._setCustomTrackers,
    this._getCustomTrackers,
    this._deleteAllCustomTrackers,
  ) {
    _getSearchProviders();
    _getCustomTrackersFromCache();
  }

  @observable
  var enabledSearchProviders = [].asObservable();

  @observable
  var customTrackers = <String>[].asObservable();

  bool hasUsecaseOfType<T>() {
    for (var usecase in enabledSearchProviders) {
      if (usecase.runtimeType == T) {
        return true;
      }
    }

    return false;
  }

  @action
  Future<void> enableSearchProvider(SearchProvider searchProvider) async {
    final result = await _enableSearchProvider(searchProvider);

    result.fold((l) => print(l), (r) {
      enabledSearchProviders.add(r);
      print(enabledSearchProviders);
    });
  }

  @action
  Future<void> disableSearchProvider<T>(SearchProvider searchProvider) async {
    enabledSearchProviders.removeWhere((element) => element.runtimeType == T);
    await _disableSearchProvider(searchProvider);
    print(enabledSearchProviders);
  }

  @action
  Future<void> _getCustomTrackersFromCache() async {
    final result = await _getCustomTrackers(NoParams());

    result.fold(
      (failure) => print(failure),
      (success) => customTrackers = success.map<String>((e) => e.toString()).toList().asObservable(),
    );
  }

  @action
  Future<void> setCustomTrackers(List<String> trackers) async {
    final result = await _setCustomTrackers(CustomTrackersParams(trackers));

    result.fold(
      (failure) => print(failure),
      (success) => customTrackers = trackers.asObservable(),
    );
  }

  @action
  Future<void> deleteCustomTrackers() async {
    final result = await _deleteAllCustomTrackers(NoParams());

    result.fold(
      (failure) => print(failure),
      (_) {},
    );
  }

  @action
  Future<void> _getSearchProviders() async {
    final result = await _getEnabledSearchProviders(NoParams());

    result.fold(
      (left) => print(left),
      (right) {
        print(right);
        enabledSearchProviders = right.asObservable();
      },
    );
  }
}
