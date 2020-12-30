import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/search_page_controller.dart';
import '../widgets/magic_magnet_logo.dart';
import '../widgets/search_field.dart';

class SearchPage extends StatelessWidget {
  final controller = Modular.get<SearchPageController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      controller.searchTextFieldController;

      return Listener(
        onPointerDown: (_) {
          final currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null)
            currentFocus.focusedChild.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 584),
                  child: MagicMagnetLogo(
                    isSearchPage: true,
                    isHero: true,
                    showTitle: true,
                  ),
                ),
                SizedBox(height: 32),
                SearchField(controller: controller, isHero: true)
              ],
            ),
          ),
        ),
      );
    });
  }
}
