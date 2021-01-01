import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';

class HomePage extends StatelessWidget {
  final appController = Modular.get<AppController>();

  void search() {
    Modular.navigator.pushNamed('/result');
    appController.performSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Listener(
          onPointerDown: (_) {
            final currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null)
              currentFocus.focusedChild.unfocus();
          },
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 14.0,
                      ),
                      child: Container(
                        height: 50,
                        width: 125,
                        child: RoundedButton(
                          onTap: () {},
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Settings',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                UniconsLine.setting,
                                color: Color(0xFF5F6368),
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  'assets/images/logo_512x512.png',
                                  scale: 10,
                                ),
                              ),
                              VerticalDivider(color: Colors.transparent),
                              Text(
                                'Magic Magnet',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(height: 36),
                          Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  controller:
                                      appController.searchTextFieldController,
                                  textInputAction: TextInputAction.search,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  enableSuggestions: true,
                                  enableInteractiveSelection: true,
                                  textAlign: TextAlign.center,
                                  showCursor: appController
                                      .searchTextFieldController
                                      .text
                                      .isNotEmpty,
                                  maxLines: 1,
                                  autocorrect: true,
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontWeight: FontWeight.w600),
                                  onSubmitted: (_) => search(),
                                  decoration: InputDecoration(
                                    hintMaxLines: 1,
                                    hintText: 'What do you wanna links for?',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              RoundedButton(
                                color: Theme.of(context).primaryColor,
                                onTap: search,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        UniconsLine.search,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
