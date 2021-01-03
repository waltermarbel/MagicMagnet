import 'package:asuka/asuka.dart' as asuka;
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/utils/user_interface/no_splash.dart';
import 'floating_snack_bar.dart';
import 'rounded_button.dart';

class DetailModal extends StatelessWidget {
  final int index;

  const DetailModal({this.index});

  @override
  Widget build(BuildContext context) {
    final appController = Modular.get<AppController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: NoSplash(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Torrent name',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              appController.magnetLinks.elementAt(index).torrentName,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Avaliability',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  '${appController.magnetLinks.elementAt(index).seeders} seeders',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text(
                  '${appController.magnetLinks.elementAt(index).leechers} leechers',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text(
                  '97% healty (ratio between seeders and leechers)',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Original source',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  'https://source.com/link',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Avaliable actions',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundedButton(
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
                          'Copy link',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    RoundedButton(
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.all(16),
                      onTap: () async {
                        if (await canLaunch(appController.magnetLinks
                            .elementAt(index)
                            .magnetLink)) {
                          await launch(
                            appController.magnetLinks
                                .elementAt(index)
                                .magnetLink,
                          );
                        } else {
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
                          'Open link',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
