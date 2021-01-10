import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../widgets/circular_button.dart';
import '../widgets/floating_snack_bar.dart';

class HomePage extends StatelessWidget {
  final appController = Modular.get<AppController>();

  Future<void> search() async {
    if (appController.enabledUsecases.isEmpty) {
      await asuka
          .showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              elevation: 0,
              content: FloatingSnackBar(
                text: 'You should enable at least 1 source in settings',
              ),
            ),
          )
          .closed;
    } else {
      appController.performSearch();

      if (appController.errorMessage.isNotEmpty) {
        final isClosed = await asuka
            .showSnackBar(
              SnackBar(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                elevation: 0,
                content: FloatingSnackBar(
                  text: appController.errorMessage,
                ),
              ),
            )
            .closed;
        if (isClosed.index != null) {
          appController.clearErrorMessage();
        }
      } else {
        Modular.navigator.pushNamed('/result');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (appController.magnetLinks.isNotEmpty) {
      appController.magnetLinks.clear();
    }

    return Listener(
      onPointerDown: (_) {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null)
          currentFocus.focusedChild.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          brightness: Theme.of(context).brightness,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            CircularButton(
              padding: const EdgeInsets.all(18),
              color: Theme.of(context).scaffoldBackgroundColor,
              onTap: () {
                Modular.navigator.pushNamed('/settings');
              },
              child: Icon(
                UniconsLine.setting,
                color: Theme.of(context).textTheme.headline6.color,
              ),
            ),
          ],
        ),
        body: Container(
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
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: TextField(
                          controller: appController.searchTextFieldController,
                          textInputAction: TextInputAction.search,
                          textCapitalization: TextCapitalization.sentences,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          textAlign: TextAlign.center,
                          showCursor: appController
                              .searchTextFieldController.text.isNotEmpty,
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
                                size: 20,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
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
                            fillColor: Theme.of(context).cardColor,
                            hintMaxLines: 1,
                            hintText: 'Search something here',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
