// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  Computed<Themes> _$currentThemeComputed;

  @override
  Themes get currentTheme =>
      (_$currentThemeComputed ??= Computed<Themes>(() => super.currentTheme,
              name: '_AppControllerBase.currentTheme'))
          .value;

  final _$magnetLinksAtom = Atom(name: '_AppControllerBase.magnetLinks');

  @override
  ObservableList<MagnetLink> get magnetLinks {
    _$magnetLinksAtom.reportRead();
    return super.magnetLinks;
  }

  @override
  set magnetLinks(ObservableList<MagnetLink> value) {
    _$magnetLinksAtom.reportWrite(value, super.magnetLinks, () {
      super.magnetLinks = value;
    });
  }

  final _$searchTextFieldControllerAtom =
      Atom(name: '_AppControllerBase.searchTextFieldController');

  @override
  TextEditingController get searchTextFieldController {
    _$searchTextFieldControllerAtom.reportRead();
    return super.searchTextFieldController;
  }

  @override
  set searchTextFieldController(TextEditingController value) {
    _$searchTextFieldControllerAtom
        .reportWrite(value, super.searchTextFieldController, () {
      super.searchTextFieldController = value;
    });
  }

  final _$enabledUsecasesAtom =
      Atom(name: '_AppControllerBase.enabledUsecases');

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
      Atom(name: '_AppControllerBase.isGoogleEnabled');

  @override
  dynamic get isGoogleEnabled {
    _$isGoogleEnabledAtom.reportRead();
    return super.isGoogleEnabled;
  }

  @override
  set isGoogleEnabled(dynamic value) {
    _$isGoogleEnabledAtom.reportWrite(value, super.isGoogleEnabled, () {
      super.isGoogleEnabled = value;
    });
  }

  final _$isTPBEnabledAtom = Atom(name: '_AppControllerBase.isTPBEnabled');

  @override
  dynamic get isTPBEnabled {
    _$isTPBEnabledAtom.reportRead();
    return super.isTPBEnabled;
  }

  @override
  set isTPBEnabled(dynamic value) {
    _$isTPBEnabledAtom.reportWrite(value, super.isTPBEnabled, () {
      super.isTPBEnabled = value;
    });
  }

  final _$is1337XEnabledAtom = Atom(name: '_AppControllerBase.is1337XEnabled');

  @override
  dynamic get is1337XEnabled {
    _$is1337XEnabledAtom.reportRead();
    return super.is1337XEnabled;
  }

  @override
  set is1337XEnabled(dynamic value) {
    _$is1337XEnabledAtom.reportWrite(value, super.is1337XEnabled, () {
      super.is1337XEnabled = value;
    });
  }

  final _$isNyaaEnabledAtom = Atom(name: '_AppControllerBase.isNyaaEnabled');

  @override
  dynamic get isNyaaEnabled {
    _$isNyaaEnabledAtom.reportRead();
    return super.isNyaaEnabled;
  }

  @override
  set isNyaaEnabled(dynamic value) {
    _$isNyaaEnabledAtom.reportWrite(value, super.isNyaaEnabled, () {
      super.isNyaaEnabled = value;
    });
  }

  final _$isEZTVEnabledAtom = Atom(name: '_AppControllerBase.isEZTVEnabled');

  @override
  dynamic get isEZTVEnabled {
    _$isEZTVEnabledAtom.reportRead();
    return super.isEZTVEnabled;
  }

  @override
  set isEZTVEnabled(dynamic value) {
    _$isEZTVEnabledAtom.reportWrite(value, super.isEZTVEnabled, () {
      super.isEZTVEnabled = value;
    });
  }

  final _$isYTSEnabledAtom = Atom(name: '_AppControllerBase.isYTSEnabled');

  @override
  dynamic get isYTSEnabled {
    _$isYTSEnabledAtom.reportRead();
    return super.isYTSEnabled;
  }

  @override
  set isYTSEnabled(dynamic value) {
    _$isYTSEnabledAtom.reportWrite(value, super.isYTSEnabled, () {
      super.isYTSEnabled = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_AppControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$hasCancelRequestAtom =
      Atom(name: '_AppControllerBase.hasCancelRequest');

  @override
  bool get hasCancelRequest {
    _$hasCancelRequestAtom.reportRead();
    return super.hasCancelRequest;
  }

  @override
  set hasCancelRequest(bool value) {
    _$hasCancelRequestAtom.reportWrite(value, super.hasCancelRequest, () {
      super.hasCancelRequest = value;
    });
  }

  final _$hasFinishedSearchAtom =
      Atom(name: '_AppControllerBase.hasFinishedSearch');

  @override
  bool get hasFinishedSearch {
    _$hasFinishedSearchAtom.reportRead();
    return super.hasFinishedSearch;
  }

  @override
  set hasFinishedSearch(bool value) {
    _$hasFinishedSearchAtom.reportWrite(value, super.hasFinishedSearch, () {
      super.hasFinishedSearch = value;
    });
  }

  final _$appThemeAtom = Atom(name: '_AppControllerBase.appTheme');

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
      AsyncAction('_AppControllerBase.fetchPreferredTheme');

  @override
  Future fetchPreferredTheme() {
    return _$fetchPreferredThemeAsyncAction
        .run(() => super.fetchPreferredTheme());
  }

  final _$changeAppThemeAsyncAction =
      AsyncAction('_AppControllerBase.changeAppTheme');

  @override
  Future<void> changeAppTheme({Themes theme}) {
    return _$changeAppThemeAsyncAction
        .run(() => super.changeAppTheme(theme: theme));
  }

  final _$enableUsecaseAsyncAction =
      AsyncAction('_AppControllerBase.enableUsecase');

  @override
  Future<void> enableUsecase(UsecaseEntity usecase) {
    return _$enableUsecaseAsyncAction.run(() => super.enableUsecase(usecase));
  }

  final _$disableUsecaseAsyncAction =
      AsyncAction('_AppControllerBase.disableUsecase');

  @override
  Future<void> disableUsecase<T>(UsecaseEntity usecase) {
    return _$disableUsecaseAsyncAction
        .run(() => super.disableUsecase<T>(usecase));
  }

  final _$_getUsecasesAsyncAction =
      AsyncAction('_AppControllerBase._getUsecases');

  @override
  Future<void> _getUsecases() {
    return _$_getUsecasesAsyncAction.run(() => super._getUsecases());
  }

  final _$performSearchAsyncAction =
      AsyncAction('_AppControllerBase.performSearch');

  @override
  Future<void> performSearch() {
    return _$performSearchAsyncAction.run(() => super.performSearch());
  }

  final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase');

  @override
  int addMagnetLink(MagnetLink magnetLink) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.addMagnetLink');
    try {
      return super.addMagnetLink(magnetLink);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancelSearch() {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.cancelSearch');
    try {
      return super.cancelSearch();
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool _hasUsecaseOfType<T>() {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase._hasUsecaseOfType<T>');
    try {
      return super._hasUsecaseOfType<T>();
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage() {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.clearErrorMessage');
    try {
      return super.clearErrorMessage();
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void markAsFinished() {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase.markAsFinished');
    try {
      return super.markAsFinished();
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _changeUsecaseValue({UsecaseEntity usecase, bool value}) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase._changeUsecaseValue');
    try {
      return super._changeUsecaseValue(usecase: usecase, value: value);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
magnetLinks: ${magnetLinks},
searchTextFieldController: ${searchTextFieldController},
enabledUsecases: ${enabledUsecases},
isGoogleEnabled: ${isGoogleEnabled},
isTPBEnabled: ${isTPBEnabled},
is1337XEnabled: ${is1337XEnabled},
isNyaaEnabled: ${isNyaaEnabled},
isEZTVEnabled: ${isEZTVEnabled},
isYTSEnabled: ${isYTSEnabled},
errorMessage: ${errorMessage},
hasCancelRequest: ${hasCancelRequest},
hasFinishedSearch: ${hasFinishedSearch},
appTheme: ${appTheme},
currentTheme: ${currentTheme}
    ''';
  }
}
