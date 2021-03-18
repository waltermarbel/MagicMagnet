// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
  final _$enabledSearchProvidersAtom =
      Atom(name: '_SettingsControllerBase.enabledSearchProviders');

  @override
  ObservableList<dynamic> get enabledSearchProviders {
    _$enabledSearchProvidersAtom.reportRead();
    return super.enabledSearchProviders;
  }

  @override
  set enabledSearchProviders(ObservableList<dynamic> value) {
    _$enabledSearchProvidersAtom
        .reportWrite(value, super.enabledSearchProviders, () {
      super.enabledSearchProviders = value;
    });
  }

  final _$enableSearchProviderAsyncAction =
      AsyncAction('_SettingsControllerBase.enableSearchProvider');

  @override
  Future<void> enableSearchProvider(SearchProvider searchProvider) {
    return _$enableSearchProviderAsyncAction
        .run(() => super.enableSearchProvider(searchProvider));
  }

  final _$disableSearchProviderAsyncAction =
      AsyncAction('_SettingsControllerBase.disableSearchProvider');

  @override
  Future<void> disableSearchProvider<T>(SearchProvider searchProvider) {
    return _$disableSearchProviderAsyncAction
        .run(() => super.disableSearchProvider<T>(searchProvider));
  }

  final _$_getSearchProvidersAsyncAction =
      AsyncAction('_SettingsControllerBase._getSearchProviders');

  @override
  Future<void> _getSearchProviders() {
    return _$_getSearchProvidersAsyncAction
        .run(() => super._getSearchProviders());
  }

  @override
  String toString() {
    return '''
enabledSearchProviders: ${enabledSearchProviders}
    ''';
  }
}
