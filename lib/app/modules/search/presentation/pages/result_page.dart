import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/search_page_controller.dart';
import '../widgets/loading_indicator.dart';
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
          body: ListView(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MagicMagnetLogo(
                      isSearchPage: false,
                      isHero: true,
                      imageHeight: 30,
                      middleDistance: 12,
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    VerticalDivider(),
                    Flexible(
                      child: SearchField(
                        controller: controller,
                        isHero: true,
                      ),
                    ),
                    VerticalDivider(),
                    SettingsButton(),
                  ],
                ),
              ),
              SizedBox(height: 16),
              if (magnetLinks.isEmpty)
                if (controller.errorMessage != null)
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: Text(
                        controller.errorMessage,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                else
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: LoadingIndicator(),
                    ),
                  )
              else
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // crossAxisCount: width of screen / card width
                      crossAxisCount: MediaQuery.of(context).size.width ~/ 250,
                      // childAspectRatio: card width / card height
                      childAspectRatio: 250 / 160,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: magnetLinks.length,
                    itemBuilder: (context, index) =>
                        magnetLinks.elementAt(index),
                  ),
                ),
              SizedBox(height: 16),
            ],
          ),
        ),
      );
    });
  }
}
