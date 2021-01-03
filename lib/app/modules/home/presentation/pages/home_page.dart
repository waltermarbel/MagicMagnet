import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../widgets/circular_button.dart';
import '../widgets/settings_modal.dart';

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
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: CircularButton(
                        padding: const EdgeInsets.all(18),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        onTap: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SettingsModal(),
                          );
                        },
                        child: Icon(
                          UniconsLine.setting,
                          color: Color(0xFF272D2F),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
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
                                      prefixIcon: GestureDetector(
                                        onTap: search,
                                        child: Icon(
                                          UniconsLine.search,
                                          color: Color(0xFF272D2F),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 8,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintMaxLines: 1,
                                      hintText: 'Search something here',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
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
