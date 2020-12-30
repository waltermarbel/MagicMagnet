import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'rounded_element.dart';

class MagicMagnetLogo extends StatelessWidget {
  final double imageHeight;
  final double middleDistance;
  final TextStyle textStyle;
  final bool isSearchPage;
  final bool isHero;
  final bool showTitle;

  const MagicMagnetLogo({
    this.imageHeight,
    this.middleDistance,
    this.textStyle,
    this.isSearchPage,
    this.isHero,
    this.showTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final widget = RoundedElement(
      onTap: isSearchPage
          ? () {}
          : () {
              Modular.navigator.pushNamed('/');
            },
      hasSplash: !isSearchPage,
      child: MediaQuery.of(context).size.width > 480 || showTitle
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_256x256.png',
                  height: imageHeight ?? 100,
                ),
                SizedBox(width: middleDistance ?? 16),
                Text(
                  'Magic Magnet',
                  style: textStyle ??
                      Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            )
          : Image.asset(
              'assets/images/logo_256x256.png',
              height: imageHeight ?? 100,
            ),
    );

    return isHero ? Hero(tag: 'Logo', child: widget) : widget;
  }
}
