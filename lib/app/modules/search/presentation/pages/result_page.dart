import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../controllers/search_page_controller.dart';
import '../widgets/magic_magnet_logo.dart';
import '../widgets/magnet_link_card.dart';
import '../widgets/search_field.dart';
import '../widgets/settings_button.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<SearchPageController>();

    return Observer(builder: (_) {
      var magnetLinks = controller.magnetLinks
          .map((element) => MagnetLinkCard(magnetLink: element))
          .toList();

      return Listener(
        onPointerDown: (_) {
          final currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null)
            currentFocus.focusedChild.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'Logo',
                      child: MagicMagnetLogo(
                        isSearchPage: false,
                        imageHeight: 30,
                        middleDistance: 12,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Hero(
                      tag: 'SearchField',
                      child: SearchField(controller: controller),
                    ),
                    SettingsButton(),
                  ],
                ),
                SizedBox(height: 24),
                Expanded(
                  child: ResponsiveGridList(
                    desiredItemWidth: 250,
                    minSpacing: 10,
                    scroll: true,
                    children: magnetLinks,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
