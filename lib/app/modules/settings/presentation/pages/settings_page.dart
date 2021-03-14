import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/domain/entities/usecase_entity.dart';
import '../../../../core/presentation/controllers/theme_controller.dart';
import '../../../../core/utils/app_config/app_config.dart';
import '../../../../core/utils/user_interface/admob.dart';
import '../../../../core/utils/user_interface/no_splash.dart';
import '../../../../core/utils/user_interface/themes.dart';
import '../../../home/presentation/widgets/circular_button.dart';
import '../controllers/settings_controller.dart';
import '../utils/extensions.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState
    extends ModularState<SettingsPage, SettingsController> {
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
          debugPrint("BannerAd event is $event");
        },
      );

      settingsBanner
        ..load()
        ..show(anchorType: AnchorType.bottom);
    }
  }

  void _showInteresticialAd() {
    InterstitialAd settingsInteresticial = InterstitialAd(
      adUnitId: AdmobCodes.settingsInteresticialID,
      targetingInfo: MobileAdTargetingInfo(),
      listener: (MobileAdEvent event) {
        debugPrint("InterstitialAd event is $event");
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

    if (AppConfig.of(context).isFree) {
      settingsBanner..dispose();
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final settingsController = Modular.get<SettingsController>();
    final themeController = Modular.get<ThemeController>();

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

                if (AppConfig.of(context).isFree) {
                  settingsBanner..dispose();
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
                  value: settingsController
                      .hasUsecaseOfType<GetMagnetLinksFromGoogle>(),
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
                        ? settingsController
                            .enableUsecase(UsecaseEntity('Google'))
                        : settingsController.disableUsecase<
                            GetMagnetLinksFromGoogle>(UsecaseEntity('Google'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: settingsController
                      .hasUsecaseOfType<GetMagnetLinksFromTPB>(),
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
                        ? settingsController
                            .enableUsecase(UsecaseEntity('The Pirate Bay'))
                        : settingsController
                            .disableUsecase<GetMagnetLinksFromTPB>(
                                UsecaseEntity('The Pirate Bay'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: settingsController
                      .hasUsecaseOfType<GetMagnetLinksFrom1337X>(),
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
                        ? settingsController
                            .enableUsecase(UsecaseEntity('1337x'))
                        : settingsController.disableUsecase<
                            GetMagnetLinksFrom1337X>(UsecaseEntity('1337x'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: settingsController
                      .hasUsecaseOfType<GetMagnetLinksFromLimeTorrents>(),
                  title: Text(
                    'LimeTorrents',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Can be slow, but works fine for the most of content',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onChanged: (value) {
                    value
                        ? settingsController
                            .enableUsecase(UsecaseEntity('LimeTorrents'))
                        : settingsController
                            .disableUsecase<GetMagnetLinksFromLimeTorrents>(
                                UsecaseEntity('LimeTorrents'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: settingsController
                      .hasUsecaseOfType<GetMagnetLinksFromNyaa>(),
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
                        ? settingsController
                            .enableUsecase(UsecaseEntity('Nyaa'))
                        : settingsController.disableUsecase<
                            GetMagnetLinksFromNyaa>(UsecaseEntity('Nyaa'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: settingsController
                      .hasUsecaseOfType<GetMagnetLinksFromEZTV>(),
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
                        ? settingsController
                            .enableUsecase(UsecaseEntity('EZTV'))
                        : settingsController.disableUsecase<
                            GetMagnetLinksFromEZTV>(UsecaseEntity('EZTV'));
                  },
                ),
                CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: settingsController
                      .hasUsecaseOfType<GetMagnetLinksFromYTS>(),
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
                        ? settingsController.enableUsecase(UsecaseEntity('YTS'))
                        : settingsController.disableUsecase<
                            GetMagnetLinksFromYTS>(UsecaseEntity('YTS'));
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
                    "Current theme: ${themeController.currentTheme.name}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Click to toogle the theme',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  value: themeController.currentTheme == Themes.dark,
                  onChanged: (value) async {
                    value
                        ? await themeController.changeAppTheme(
                            theme: Themes.dark)
                        : await themeController.changeAppTheme(
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
