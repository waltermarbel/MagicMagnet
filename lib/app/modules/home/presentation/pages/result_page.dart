import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/utils/user_interface/no_splash.dart';
import '../widgets/circular_button.dart';
import '../widgets/floating_snack_bar.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/result_card.dart';
import '../widgets/rounded_button.dart';
import 'package:asuka/asuka.dart' as asuka;

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appController = Modular.get<AppController>();

    return Listener(
      onPointerDown: (_) {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null)
          currentFocus.focusedChild.unfocus();
      },
      child: Observer(
        builder: (_) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: appController.hasFinishedSearch ||
                    appController.hasCancelRequest
                ? null
                : Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: RoundedButton(
                      color: Colors.redAccent[700],
                      padding: EdgeInsets.all(16),
                      onTap: () => appController.cancelSearch(),
                      child: Center(
                        child: Text(
                          'Cancel search',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              brightness: Theme.of(context).brightness,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: CircularButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                onTap: () async {
                  await Modular.navigator.maybePop();
                },
                child: Icon(
                  UniconsLine.arrow_left,
                  size: 30,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
              ),
              title: Text(
                'Results for ${appController.searchTextFieldController.text}',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            body: appController.magnetLinks.isEmpty &&
                    !appController.hasCancelRequest
                ? Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: LoadingIndicator(),
                    ),
                  )
                : NoSplash(
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${appController.magnetLinks.length} links has been found',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Click in each tile for more info',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          shrinkWrap: true,
                          addRepaintBoundaries: true,
                          cacheExtent: MediaQuery.of(context).size.height * 5,
                          itemCount: appController.magnetLinks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ResultCard(
                                magnetLink:
                                    appController.magnetLinks.elementAt(index),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
