import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'rounded_element.dart';

class MagicMagnetLogo extends StatelessWidget {
  final double imageHeight;
  final double middleDistance;
  final TextStyle textStyle;
  final bool isSearchPage;

  const MagicMagnetLogo({
    this.imageHeight,
    this.middleDistance,
    this.textStyle,
    this.isSearchPage,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedElement(
      onTap: () {
        Modular.navigator.pushNamed('/');
      },
      hasSplash: !isSearchPage,
      child: Row(
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
      ),
    );
  }
}
