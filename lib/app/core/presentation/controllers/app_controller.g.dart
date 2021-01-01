// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
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
  List<dynamic> get enabledUsecases {
    _$enabledUsecasesAtom.reportRead();
    return super.enabledUsecases;
  }

  @override
  set enabledUsecases(List<dynamic> value) {
    _$enabledUsecasesAtom.reportWrite(value, super.enabledUsecases, () {
      super.enabledUsecases = value;
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

  @override
  String toString() {
    return '''
magnetLinks: ${magnetLinks},
searchTextFieldController: ${searchTextFieldController},
enabledUsecases: ${enabledUsecases},
errorMessage: ${errorMessage}
    ''';
  }
}
