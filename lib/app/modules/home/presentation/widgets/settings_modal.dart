import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/utils/user_interface/no_splash.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal();

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
              'Avaliable sources',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              'The Pirate Bay',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
