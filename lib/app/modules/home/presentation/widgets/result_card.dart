import 'package:asuka/asuka.dart' as asuka;
import 'package:clipboard/clipboard.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_config/app_config.dart';
import '../../../../core/utils/user_interface/admob.dart';
import 'detail_modal.dart';
import 'floating_snack_bar.dart';
import 'rounded_button.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({@required this.magnetLink});

  final MagnetLink magnetLink;

  @override
  Widget build(BuildContext context) {
    void _showDetailInteresticialAd() {
      // ignore: unused_local_variable
      final detailInteresticial = InterstitialAd(
        adUnitId: AdmobCodes.detailInteresticialID,
        targetingInfo: const MobileAdTargetingInfo(),
        listener: (MobileAdEvent event) {
          debugPrint('InterstitialAd event is $event');
        },
      )
        ..load()
        ..show();
    }

    void _showCopyInteresticialAd() {
      // ignore: unused_local_variable
      final copyInteresticial = InterstitialAd(
        adUnitId: AdmobCodes.copyInteresticialID,
        targetingInfo: const MobileAdTargetingInfo(),
        listener: (MobileAdEvent event) {
          debugPrint('InterstitialAd event is $event');
        },
      )
        ..load()
        ..show();
    }

    Future<void> _showOpenInteresticialAd() async {
      final InterstitialAd openInteresticial = InterstitialAd(
        adUnitId: AdmobCodes.openInteresticialID,
        targetingInfo: const MobileAdTargetingInfo(),
        listener: (MobileAdEvent event) {
          debugPrint('InterstitialAd event is $event');
        },
      );

      await openInteresticial.load();
      await openInteresticial.show();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              showMaterialModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => DetailModal(magnetLink: magnetLink),
              ).whenComplete(() {
                if (AppConfig.of(context).isFree) {
                  _showDetailInteresticialAd();
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/launcher/foreground.png',
                  scale: 7,
                ),
                Flexible(
                  child: Text(
                    magnetLink.torrentName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    color: Theme.of(context).accentColor,
                    padding: const EdgeInsets.all(16),
                    onTap: () async {
                      if (AppConfig.of(context).isFree) {
                        _showCopyInteresticialAd();
                      }

                      await FlutterClipboard.copy(
                        magnetLink.magnetLink,
                      ).then(
                        (_) => asuka.showSnackBar(
                          const SnackBar(
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
                const VerticalDivider(width: 6),
                Expanded(
                  child: RoundedButton(
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.all(16),
                    onTap: () async {
                      if (AppConfig.of(context).isFree) {
                        await _showOpenInteresticialAd();
                      }

                      try {
                        await launch(magnetLink.magnetLink);
                      } catch (e) {
                        asuka.showSnackBar(
                          const SnackBar(
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
