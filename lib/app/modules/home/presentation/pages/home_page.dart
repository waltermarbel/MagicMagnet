import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/utils/app_config/app_config.dart';
import '../../../../core/utils/user_interface/admob.dart';
import '../widgets/circular_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool isAdLoaded = false;

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  BannerAd homeBanner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppConfig.of(context).isFree) {
      homeBanner = BannerAd(
        adUnitId: AdmobCodes.homeBannerID,
        size: AdSize.banner,
        targetingInfo: MobileAdTargetingInfo(),
        listener: (MobileAdEvent event) {
          debugPrint("BannerAd event is $event");
        },
      );

      homeBanner
        ..load()
        ..show(anchorType: AnchorType.bottom);

      isAdLoaded = true;
    }
  }

  @override
  void dispose() {
    if (isAdLoaded) {
      homeBanner..dispose();
      isAdLoaded = false;
    }

    super.dispose();
  }

  Future<void> search() async {
    if (isAdLoaded) {
      homeBanner..dispose();
      isAdLoaded = false;
    }

    if (textController.text.isNotEmpty || textController.text != '') {
      Modular.navigator.pushNamed('/search/${textController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          controller: textController,
                          textInputAction: TextInputAction.search,
                          textCapitalization: TextCapitalization.sentences,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          textAlign: TextAlign.center,
                          showCursor: textController.text.isNotEmpty,
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
