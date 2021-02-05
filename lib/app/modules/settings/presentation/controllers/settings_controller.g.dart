// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
  Computed<Themes> _$currentThemeComputed;

  @override
  Themes get currentTheme =>
      (_$currentThemeComputed ??= Computed<Themes>(() => super.currentTheme,
              name: '_SettingsControllerBase.currentTheme'))
          .value;

  final _$enabledUsecasesAtom =
      Atom(name: '_SettingsControllerBase.enabledUsecases');

  @override
  ObservableList<dynamic> get enabledUsecases {
    _$enabledUsecasesAtom.reportRead();
    return super.enabledUsecases;
  }

  @override
  set enabledUsecases(ObservableList<dynamic> value) {
    _$enabledUsecasesAtom.reportWrite(value, super.enabledUsecases, () {
      super.enabledUsecases = value;
    });
  }

  final _$isGoogleEnabledAtom =
      Atom(name: '_SettingsControllerBase.isGoogleEnabled');

  @override
  bool get isGoogleEnabled {
    _$isGoogleEnabledAtom.reportRead();
    return super.isGoogleEnabled;
  }

  @override
  set isGoogleEnabled(bool value) {
    _$isGoogleEnabledAtom.reportWrite(value, super.isGoogleEnabled, () {
      super.isGoogleEnabled = value;
    });
  }

  final _$isTPBEnabledAtom = Atom(name: '_SettingsControllerBase.isTPBEnabled');

  @override
  bool get isTPBEnabled {
    _$isTPBEnabledAtom.reportRead();
    return super.isTPBEnabled;
  }

  @override
  set isTPBEnabled(bool value) {
    _$isTPBEnabledAtom.reportWrite(value, super.isTPBEnabled, () {
      super.isTPBEnabled = value;
    });
  }

  final _$is1337XEnabledAtom =
      Atom(name: '_SettingsControllerBase.is1337XEnabled');

  @override
  bool get is1337XEnabled {
    _$is1337XEnabledAtom.reportRead();
    return super.is1337XEnabled;
  }

  @override
  set is1337XEnabled(bool value) {
    _$is1337XEnabledAtom.reportWrite(value, super.is1337XEnabled, () {
      super.is1337XEnabled = value;
    });
  }

  final _$isNyaaEnabledAtom =
      Atom(name: '_SettingsControllerBase.isNyaaEnabled');

  @override
  bool get isNyaaEnabled {
    _$isNyaaEnabledAtom.reportRead();
    return super.isNyaaEnabled;
  }

  @override
  set isNyaaEnabled(bool value) {
    _$isNyaaEnabledAtom.reportWrite(value, super.isNyaaEnabled, () {
      super.isNyaaEnabled = value;
    });
  }

  final _$isEZTVEnabledAtom =
      Atom(name: '_SettingsControllerBase.isEZTVEnabled');

  @override
  bool get isEZTVEnabled {
    _$isEZTVEnabledAtom.reportRead();
    return super.isEZTVEnabled;
  }

  @override
  set isEZTVEnabled(bool value) {
    _$isEZTVEnabledAtom.reportWrite(value, super.isEZTVEnabled, () {
      super.isEZTVEnabled = value;
    });
  }

  final _$isYTSEnabledAtom = Atom(name: '_SettingsControllerBase.isYTSEnabled');

  @override
  bool get isYTSEnabled {
    _$isYTSEnabledAtom.reportRead();
    return super.isYTSEnabled;
  }

  @override
  set isYTSEnabled(bool value) {
    _$isYTSEnabledAtom.reportWrite(value, super.isYTSEnabled, () {
      super.isYTSEnabled = value;
    });
  }

  final _$isLimeTorrentsEnabledAtom =
      Atom(name: '_SettingsControllerBase.isLimeTorrentsEnabled');

  @override
  bool get isLimeTorrentsEnabled {
    _$isLimeTorrentsEnabledAtom.reportRead();
    return super.isLimeTorrentsEnabled;
  }

  @override
  set isLimeTorrentsEnabled(bool value) {
    _$isLimeTorrentsEnabledAtom.reportWrite(value, super.isLimeTorrentsEnabled,
        () {
      super.isLimeTorrentsEnabled = value;
    });
  }

  final _$appThemeAtom = Atom(name: '_SettingsControllerBase.appTheme');

  @override
  ThemeData get appTheme {
    _$appThemeAtom.reportRead();
    return super.appTheme;
  }

  @override
  set appTheme(ThemeData value) {
    _$appThemeAtom.reportWrite(value, super.appTheme, () {
      super.appTheme = value;
    });
  }

  final _$fetchPreferredThemeAsyncAction =
      AsyncAction('_SettingsControllerBase.fetchPreferredTheme');

  @override
  Future fetchPreferredTheme() {
    return _$fetchPreferredThemeAsyncAction
        .run(() => super.fetchPreferredTheme());
  }

  final _$changeAppThemeAsyncAction =
      AsyncAction('_SettingsControllerBase.changeAppTheme');

  @override
  Future<void> changeAppTheme({Themes theme}) {
    return _$changeAppThemeAsyncAction
        .run(() => super.changeAppTheme(theme: theme));
  }

  final _$enableUsecaseAsyncAction =
      AsyncAction('_SettingsControllerBase.enableUsecase');

  @override
  Future<void> enableUsecase(UsecaseEntity usecase) {
    return _$enableUsecaseAsyncAction.run(() => super.enableUsecase(usecase));
  }

  final _$disableUsecaseAsyncAction =
      AsyncAction('_SettingsControllerBase.disableUsecase');

  @override
  Future<void> disableUsecase<T>(UsecaseEntity usecase) {
    return _$disableUsecaseAsyncAction
        .run(() => super.disableUsecase<T>(usecase));
  }

  final _$_getUsecasesAsyncAction =
      AsyncAction('_SettingsControllerBase._getUsecases');

  @override
  Future<void> _getUsecases() {
    return _$_getUsecasesAsyncAction.run(() => super._getUsecases());
  }

  final _$_SettingsControllerBaseActionController =
      ActionController(name: '_SettingsControllerBase');

  @override
  bool _hasUsecaseOfType<T>() {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
        name: '_SettingsControllerBase._hasUsecaseOfType<T>');
    try {
      return super._hasUsecaseOfType<T>();
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _changeUsecaseValue({UsecaseEntity usecase, bool value}) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
        name: '_SettingsControllerBase._changeUsecaseValue');
    try {
      return super._changeUsecaseValue(usecase: usecase, value: value);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enabledUsecases: ${enabledUsecases},
isGoogleEnabled: ${isGoogleEnabled},
isTPBEnabled: ${isTPBEnabled},
is1337XEnabled: ${is1337XEnabled},
isNyaaEnabled: ${isNyaaEnabled},
isEZTVEnabled: ${isEZTVEnabled},
isYTSEnabled: ${isYTSEnabled},
isLimeTorrentsEnabled: ${isLimeTorrentsEnabled},
appTheme: ${appTheme},
currentTheme: ${currentTheme}
    ''';
  }
}
