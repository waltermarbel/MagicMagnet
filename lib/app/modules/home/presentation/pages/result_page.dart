import 'package:asuka/asuka.dart' as asuka;
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/utils/user_interface/no_splash.dart';
import '../widgets/circular_button.dart';
import '../widgets/detail_modal.dart';
import '../widgets/floating_snack_bar.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/rounded_button.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appController = Modular.get<AppController>();

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
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFF272D2F)),
              centerTitle: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: CircularButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                onTap: () {
                  Modular.navigator.maybePop();
                },
                child: Icon(
                  UniconsLine.arrow_left,
                  size: 30,
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
            body: appController.magnetLinks.isEmpty
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
                          cacheExtent: 10000,
                          shrinkWrap: true,
                          itemCount: appController.magnetLinks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ResultCard(
                                index: index,
                                appController: appController,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class ResultCard extends StatelessWidget {
  const ResultCard({
    @required this.appController,
    @required this.index,
  })  : assert(appController != null),
        assert(index != null);

  final AppController appController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              showMaterialModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => DetailModal(index: index),
              );
            },
            title: Text(
              appController.magnetLinks.elementAt(index).torrentName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            leading: Image.asset(
              'assets/launcher/foreground.png',
              scale: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    color: Theme.of(context).accentColor,
                    padding: EdgeInsets.all(16),
                    onTap: () async {
                      await FlutterClipboard.copy(
                        appController.magnetLinks.elementAt(index).magnetLink,
                      ).then(
                        (_) => asuka.showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            content: FloatingSnackBar(
                              text:
                                  'Magnet link sucessfully copied to clipboard',
                            ),
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Copy magnet link',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 6),
                Expanded(
                  child: RoundedButton(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(16),
                    onTap: () async {
                      try {
                        await launch(
                          appController.magnetLinks.elementAt(index).magnetLink,
                        );
                      } catch (e) {
                        asuka.showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            content: FloatingSnackBar(
                              text:
                                  "You don't have any compatible app to open this link",
                            ),
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Text(
                        'Open magnet link',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
