import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/google.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:mobx/mobx.dart';

part 'search_page_controller.g.dart';

class SearchPageController = _SearchPageControllerBase
    with _$SearchPageController;

abstract class _SearchPageControllerBase with Store {
  @observable
  var searchTextFieldController = TextEditingController();

  @observable
  var magnetLinks = <MagnetLink>[].asObservable();

  @action
  Future<void> performSearch(String content) async {
    magnetLinks.clear();

    final usecase = Modular.get<GetMagnetLinksFromGoogle>();

    final result = usecase(SearchParameters(content));

    result.fold((l) => print(l), (r) {
      r.listen((event) {
        magnetLinks.add(event);
      });
    });
  }
}
