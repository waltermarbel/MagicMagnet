// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeController on _ThemeControllerBase, Store {
  Computed<Themes> _$currentThemeComputed;

  @override
  Themes get currentTheme =>
      (_$currentThemeComputed ??= Computed<Themes>(() => super.currentTheme,
              name: '_ThemeControllerBase.currentTheme'))
          .value;

  final _$appThemeAtom = Atom(name: '_ThemeControllerBase.appTheme');

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
      AsyncAction('_ThemeControllerBase.fetchPreferredTheme');

  @override
  Future<void> fetchPreferredTheme() {
    return _$fetchPreferredThemeAsyncAction
        .run(() => super.fetchPreferredTheme());
  }

  final _$changeAppThemeAsyncAction =
      AsyncAction('_ThemeControllerBase.changeAppTheme');

  @override
  Future<void> changeAppTheme({Themes theme}) {
    return _$changeAppThemeAsyncAction
        .run(() => super.changeAppTheme(theme: theme));
  }

  @override
  String toString() {
    return '''
appTheme: ${appTheme},
currentTheme: ${currentTheme}
    ''';
  }
}
