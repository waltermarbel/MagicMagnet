import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/utils/user_interface/no_splash.dart';
import '../widgets/circular_button.dart';
import '../widgets/detail_modal.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/rounded_button.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appController = Modular.get<AppController>();

    return Observer(builder: (_) {
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
                      SizedBox(height: 16),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        separatorBuilder: (_, __) => SizedBox(height: 16),
                        shrinkWrap: true,
                        itemCount: appController.magnetLinks.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showMaterialModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => DetailModal(index: index),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
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
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      appController.magnetLinks
                                          .elementAt(index)
                                          .torrentName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
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
                                            color:
                                                Theme.of(context).accentColor,
                                            padding: EdgeInsets.all(16),
                                            onTap: () {},
                                            child: Center(
                                              child: Text(
                                                'Copy link',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(width: 6),
                                        Expanded(
                                          child: RoundedButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            padding: EdgeInsets.all(16),
                                            onTap: () {},
                                            child: Center(
                                              child: Text(
                                                'Open link',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
