import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/domain/entities/search_provider.dart';
import '../../../../core/domain/usecases/disable_search_provider.dart';
import '../../../../core/domain/usecases/enable_search_provider.dart';
import '../../../../core/domain/usecases/get_enabled_search_providers.dart';

part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  final GetEnabledSearchProviders _getEnabledSearchProviders;
  final EnableSearchProvider _enableSearchProvider;
  final DisableSearchProvider _disableSearchProvider;

  _SettingsControllerBase(
    this._getEnabledSearchProviders,
    this._enableSearchProvider,
    this._disableSearchProvider,
  ) {
    _getSearchProviders();
  }

  @observable
  var enabledSearchProviders = [].asObservable();

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
