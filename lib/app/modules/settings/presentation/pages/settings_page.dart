import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/domain/entities/search_provider.dart';
import '../../../../core/presentation/controllers/theme_controller.dart';
import '../../../../core/utils/app_config/app_config.dart';
import '../../../../core/utils/user_interface/admob.dart';
import '../../../../core/utils/user_interface/no_splash.dart';
import '../../../../core/utils/user_interface/themes.dart';
import '../../../home/presentation/widgets/circular_button.dart';
import '../../../home/presentation/widgets/rounded_button.dart';
import '../controllers/settings_controller.dart';
import '../utils/extensions.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ModularState<SettingsPage, SettingsController> {
  final settingsController = Modular.get<SettingsController>();
  final themeController = Modular.get<ThemeController>();
  final trackersTextField = TextEditingController();
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
    Future<void> setCustomTrackers() async {
      final trackers = trackersTextField.text.split('\n')
        ..forEach((e) => e.trim())
        ..removeWhere((e) => e == '');

      await settingsController.setCustomTrackers(trackers).then(
        (_) {
          trackersTextField.text = trackers.isNotEmpty ? trackers.reduce((a, b) => a += '\n$b') : null;
          print('Saved');
        },
      );
    }

    return Listener(
      onPointerDown: (_) {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) currentFocus.focusedChild.unfocus();
      },
      child: WillPopScope(
        onWillPop: _willPop,
        child: Observer(builder: (_) {
          if (settingsController.customTrackers.isNotEmpty && trackersTextField.text.isEmpty) {
            trackersTextField.text = settingsController.customTrackers.reduce((a, b) => a += '\n$b');
          }

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
                style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            body: NoSplash(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  SizedBox(height: 6),
                  Text(
                    'Avaliable sources',
                    style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: settingsController.hasUsecaseOfType<GetMagnetLinksFromGoogle>(),
                    title: Text(
                      'Google',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Can be slow sometimes, but works very well for dubbed content',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onChanged: (value) {
                      value
                          ? settingsController.enableSearchProvider(SearchProvider('Google'))
                          : settingsController
                              .disableSearchProvider<GetMagnetLinksFromGoogle>(SearchProvider('Google'));
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: settingsController.hasUsecaseOfType<GetMagnetLinksFromTPB>(),
                    title: Text(
                      'The Pirate Bay',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Very fast, and works for most of contents',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onChanged: (value) {
                      value
                          ? settingsController.enableSearchProvider(SearchProvider('The Pirate Bay'))
                          : settingsController
                              .disableSearchProvider<GetMagnetLinksFromTPB>(SearchProvider('The Pirate Bay'));
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: settingsController.hasUsecaseOfType<GetMagnetLinksFrom1337X>(),
                    title: Text(
                      '1337x',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Fast as TPB, but with less results',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onChanged: (value) {
                      value
                          ? settingsController.enableSearchProvider(SearchProvider('1337x'))
                          : settingsController.disableSearchProvider<GetMagnetLinksFrom1337X>(SearchProvider('1337x'));
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: settingsController.hasUsecaseOfType<GetMagnetLinksFromLimeTorrents>(),
                    title: Text(
                      'LimeTorrents',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Can be slow, but works fine for the most of content',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onChanged: (value) {
                      value
                          ? settingsController.enableSearchProvider(SearchProvider('LimeTorrents'))
                          : settingsController
                              .disableSearchProvider<GetMagnetLinksFromLimeTorrents>(SearchProvider('LimeTorrents'));
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: settingsController.hasUsecaseOfType<GetMagnetLinksFromNyaa>(),
                    title: Text(
                      'Nyaa',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Very fast, the best provider for anime RAWs',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onChanged: (value) {
                      value
                          ? settingsController.enableSearchProvider(SearchProvider('Nyaa'))
                          : settingsController.disableSearchProvider<GetMagnetLinksFromNyaa>(SearchProvider('Nyaa'));
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: settingsController.hasUsecaseOfType<GetMagnetLinksFromEZTV>(),
                    title: Text(
                      'EZTV',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Usually fast, and focused in TV Shows',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onChanged: (value) {
                      value
                          ? settingsController.enableSearchProvider(SearchProvider('EZTV'))
                          : settingsController.disableSearchProvider<GetMagnetLinksFromEZTV>(SearchProvider('EZTV'));
                    },
                  ),
                  CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: settingsController.hasUsecaseOfType<GetMagnetLinksFromYTS>(),
                    title: Text(
                      'YTS',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Usually fast, and focused in english lightweight movies',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onChanged: (value) {
                      value
                          ? settingsController.enableSearchProvider(SearchProvider('YTS'))
                          : settingsController.disableSearchProvider<GetMagnetLinksFromYTS>(SearchProvider('YTS'));
                    },
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Custom trackers',
                    style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          'You can use custom trackers to improve your magnet links. One tracker per line.',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: trackersTextField,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          textAlign: TextAlign.start,
                          maxLines: null,
                          showCursor: trackersTextField.text.isNotEmpty,
                          autocorrect: true,
                          cursorColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              setCustomTrackers();
                            }
                          },
                          style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                            hintText: 'udp://example.custom-tracker.org:9999',
                            hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 12),
                        RoundedButton(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.all(16),
                          onTap: () async => await setCustomTrackers(),
                          child: Center(
                            child: Text(
                              'Save custom trackers',
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'App preferences',
                    style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SwitchListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      "Current theme: ${themeController.currentTheme.name}",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Click to toogle the theme',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    value: themeController.currentTheme == Themes.dark,
                    onChanged: (value) async {
                      value
                          ? await themeController.changeAppTheme(theme: Themes.dark)
                          : await themeController.changeAppTheme(theme: Themes.light);
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
