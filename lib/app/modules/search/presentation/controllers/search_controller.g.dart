// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on _SearchControllerBase, Store {
  final _$magnetLinksAtom = Atom(name: '_SearchControllerBase.magnetLinks');

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

  final _$errorMessageAtom = Atom(name: '_SearchControllerBase.errorMessage');

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
      Atom(name: '_SearchControllerBase.hasCancelRequest');

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
      Atom(name: '_SearchControllerBase.hasFinishedSearch');

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

  final _$performSearchAsyncAction =
      AsyncAction('_SearchControllerBase.performSearch');

  @override
  Future<void> performSearch(String content) {
    return _$performSearchAsyncAction.run(() => super.performSearch(content));
  }

  final _$_SearchControllerBaseActionController =
      ActionController(name: '_SearchControllerBase');

  @override
  void cancelSearch() {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.cancelSearch');
    try {
      return super.cancelSearch();
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage() {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.clearErrorMessage');
    try {
      return super.clearErrorMessage();
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void markAsFinished() {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.markAsFinished');
    try {
      return super.markAsFinished();
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int addMagnetLink(MagnetLink magnetLink) {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.addMagnetLink');
    try {
      return super.addMagnetLink(magnetLink);
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
magnetLinks: ${magnetLinks},
errorMessage: ${errorMessage},
hasCancelRequest: ${hasCancelRequest},
hasFinishedSearch: ${hasFinishedSearch}
    ''';
  }
}
