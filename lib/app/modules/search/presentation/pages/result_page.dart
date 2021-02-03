import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/utils/app_config/app_config.dart';
import '../../../../core/utils/user_interface/admob.dart';
import '../../../../core/utils/user_interface/no_splash.dart';
import '../../../home/presentation/widgets/circular_button.dart';
import '../../../home/presentation/widgets/loading_indicator.dart';
import '../../../home/presentation/widgets/result_card.dart';
import '../../../home/presentation/widgets/rounded_button.dart';
import '../controllers/search_controller.dart';

class ResultPage extends StatefulWidget {
  final String content;

  const ResultPage({@required this.content});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final searchController = Modular.get<SearchController>();

  BannerAd resultsBanner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (AppConfig.of(context).isFree) {
      resultsBanner = BannerAd(
        adUnitId: AdmobCodes.resultsBannerID,
        size: AdSize.smartBanner,
        targetingInfo: MobileAdTargetingInfo(),
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (AppConfig.of(context).isFree) {
      resultsBanner..dispose();
    }
  }

  void _showInteresticialAd() {
    InterstitialAd resultsInteresticial = InterstitialAd(
      adUnitId: AdmobCodes.resultsInteresticialID,
      targetingInfo: MobileAdTargetingInfo(),
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );

    resultsInteresticial
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
    searchController.performSearch(widget.content);

    return WillPopScope(
      onWillPop: _willPop,
      child: Listener(
        onPointerDown: (_) {
          final currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null)
            currentFocus.focusedChild.unfocus();
        },
        child: Observer(
          builder: (_) {
            if (AppConfig.of(context).isFree &&
                (searchController.hasFinishedSearch ||
                    searchController.hasCancelRequest)) {
              resultsBanner
                ..load()
                ..show(anchorType: AnchorType.top);
            }

            return Scaffold(
              floatingActionButtonAnimator: _NoScalingAnimation(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: searchController.hasFinishedSearch ||
                      searchController.hasCancelRequest
                  ? null
                  : Container(
                      height: 55,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: RoundedButton(
                        color: Colors.redAccent[700],
                        padding: EdgeInsets.all(16),
                        onTap: () => searchController.cancelSearch(),
                        child: Center(
                          child: Text(
                            'Cancel search',
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
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
                  'Results for ${widget.content}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              body: searchController.magnetLinks.isEmpty &&
                      !searchController.hasCancelRequest &&
                      !searchController.hasFinishedSearch
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
                                  '${searchController.magnetLinks.length} links has been found',
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
                            itemCount: searchController.magnetLinks.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ResultCard(
                                  magnetLink: searchController.magnetLinks
                                      .elementAt(index),
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
      ),
    );
  }
}

class _NoScalingAnimation extends FloatingActionButtonAnimator {
  double _x;
  double _y;
  @override
  Offset getOffset({Offset begin, Offset end, double progress}) {
    _x = begin.dx + (end.dx - begin.dx) * progress;
    _y = begin.dy + (end.dy - begin.dy) * progress;
    return Offset(_x, _y);
  }

  @override
  Animation<double> getRotationAnimation({Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}
