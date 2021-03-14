// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on _SearchControllerBase, Store {
  final _$stateAtom = Atom(name: '_SearchControllerBase.state');

  @override
  SearchState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SearchState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

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

  final _$_getUsecasesAsyncAction =
      AsyncAction('_SearchControllerBase._getUsecases');

  @override
  Future<void> _getUsecases() {
    return _$_getUsecasesAsyncAction.run(() => super._getUsecases());
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
  int _addMagnetLink(MagnetLink magnetLink) {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase._addMagnetLink');
    try {
      return super._addMagnetLink(magnetLink);
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancelSearch(String content) {
    final _$actionInfo = _$_SearchControllerBaseActionController.startAction(
        name: '_SearchControllerBase.cancelSearch');
    try {
      return super.cancelSearch(content);
    } finally {
      _$_SearchControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
magnetLinks: ${magnetLinks}
    ''';
  }
}
