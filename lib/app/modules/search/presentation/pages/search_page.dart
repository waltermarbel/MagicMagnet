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
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(tag: 'Logo', child: MagicMagnetLogo(isSearchPage: true)),
                  SizedBox(height: 32),
                  Hero(
                    tag: 'SearchField',
                    child: SearchField(controller: controller),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
