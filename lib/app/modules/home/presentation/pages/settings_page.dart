import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/domain/entities/usecase_entity.dart';
import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/utils/flavors/app_config.dart';
import '../../../../core/utils/user_interface/admob.dart';
import '../../../../core/utils/user_interface/no_splash.dart';
import '../../../../core/utils/user_interface/themes.dart';
import '../widgets/circular_button.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final appController = Modular.get<AppController>();

  BannerAd settingsBanner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (AppConfig.of(context).isFree) {
      settingsBanner = BannerAd(
        adUnitId: AdmobCodes.settingsBannerID,
        size: AdSize.smartBanner,
        targetingInfo: MobileAdTargetingInfo(),
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        },
      );

      settingsBanner
        ..load()
        ..show(anchorType: AnchorType.bottom);
    }
  }

  @override
  void dispose() {
    if (AppConfig.of(context).isFree) {
      settingsBanner..dispose();
    }

    super.dispose();
  }

  void _showInteresticialAd() {
    InterstitialAd settingsInteresticial = InterstitialAd(
      adUnitId: AdmobCodes.settingsInteresticialID,
      targetingInfo: MobileAdTargetingInfo(),
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );

    settingsInteresticial
      ..load()
      ..show();
  }

  Future<bool> _willPop() async {
    if (AppConfig.of(context).isFree) {
      _showInteresticialAd();
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Observer(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            brightness: Theme.of(context).brightness,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: CircularButton(
              color: Theme.of(context).scaffoldBackgroundColor,
              onTap: () async {
                await Modular.navigator.maybePop();

                if (AppConfig.of(context).isFree) {
                  _showInteresticialAd();
                }
              },
              child: Icon(
                UniconsLine.arrow_left,
                size: 30,
                color: Theme.of(context).textTheme.headline6.color,
              ),
            ),
            title: Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: NoSplash(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                SizedBox(height: 6),
                Text(
                  'Avaliable sources',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: appController.isGoogleEnabled,
                  title: Text(
                    'Google',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Can be slow sometimes, but works very well for dubbed content',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onChanged: (value) {
                    value
                        ? appController.enableUsecase(UsecaseEntity('Google'))
                        : appController.disableUsecase<
                            GetMagnetLinksFromGoogle>(UsecaseEntity('Google'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: appController.isTPBEnabled,
                  title: Text(
                    'The Pirate Bay',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Very fast, and works for most of contents',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onChanged: (value) {
                    value
                        ? appController
                            .enableUsecase(UsecaseEntity('The Pirate Bay'))
                        : appController.disableUsecase<GetMagnetLinksFromTPB>(
                            UsecaseEntity('The Pirate Bay'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: appController.is1337XEnabled,
                  title: Text(
                    '1337x',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Fast as TPB, but with less results',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onChanged: (value) {
                    value
                        ? appController.enableUsecase(UsecaseEntity('1337x'))
                        : appController.disableUsecase<GetMagnetLinksFrom1337X>(
                            UsecaseEntity('1337x'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: appController.isNyaaEnabled,
                  title: Text(
                    'Nyaa',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Very fast, the best provider for anime RAWs',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onChanged: (value) {
                    value
                        ? appController.enableUsecase(UsecaseEntity('Nyaa'))
                        : appController.disableUsecase<GetMagnetLinksFromNyaa>(
                            UsecaseEntity('Nyaa'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: appController.isEZTVEnabled,
                  title: Text(
                    'EZTV',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Usually fast, and focused in TV Shows',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onChanged: (value) {
                    value
                        ? appController.enableUsecase(UsecaseEntity('EZTV'))
                        : appController.disableUsecase<GetMagnetLinksFromEZTV>(
                            UsecaseEntity('EZTV'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: appController.isYTSEnabled,
                  title: Text(
                    'YTS',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Usually fast, and focused in english lightweight movies',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onChanged: (value) {
                    value
                        ? appController.enableUsecase(UsecaseEntity('YTS'))
                        : appController.disableUsecase<GetMagnetLinksFromYTS>(
                            UsecaseEntity('YTS'));
                  },
                ),
                SizedBox(height: 12),
                Text(
                  'App preferences',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SwitchListTile(
                  activeColor: Theme.of(context).primaryColor,
                  title: Text(
                    "Current theme: ${appController.currentTheme == Themes.light ? 'Light' : 'Dark'}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Click to toogle the theme',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  value: appController.currentTheme == Themes.dark,
                  onChanged: (value) async {
                    value
                        ? await appController.changeAppTheme(theme: Themes.dark)
                        : await appController.changeAppTheme(
                            theme: Themes.light);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
