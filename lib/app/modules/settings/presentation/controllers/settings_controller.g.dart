// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
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

  @override
  String toString() {
    return '''
enabledUsecases: ${enabledUsecases}
    ''';
  }
}
