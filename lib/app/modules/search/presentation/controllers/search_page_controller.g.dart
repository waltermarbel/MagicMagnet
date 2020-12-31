// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchPageController on _SearchPageControllerBase, Store {
  final _$searchTextFieldControllerAtom =
      Atom(name: '_SearchPageControllerBase.searchTextFieldController');

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

  final _$magnetLinksAtom = Atom(name: '_SearchPageControllerBase.magnetLinks');

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

  final _$errorMessageAtom =
      Atom(name: '_SearchPageControllerBase.errorMessage');

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

  final _$performSearchAsyncAction =
      AsyncAction('_SearchPageControllerBase.performSearch');

  @override
  Future<void> performSearch(String content) {
    return _$performSearchAsyncAction.run(() => super.performSearch(content));
  }

  @override
  String toString() {
    return '''
searchTextFieldController: ${searchTextFieldController},
magnetLinks: ${magnetLinks},
errorMessage: ${errorMessage}
    ''';
  }
}
