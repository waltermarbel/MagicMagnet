import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../../../core/domain/entities/usecase_entity.dart';
import '../../../../core/presentation/controllers/app_controller.dart';
import '../../../../core/utils/user_interface/no_splash.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal();

  @override
  Widget build(BuildContext context) {
    final appController = Modular.get<AppController>();

    return Observer(builder: (_) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'The Pirate Bay',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: appController.isTPBEnabled,
                    onChanged: (value) {
                      value
                          ? appController
                              .enableUsecase(UsecaseEntity('The Pirate Bay'))
                          : appController.disableUsecase<GetMagnetLinksFromTPB>(
                              UsecaseEntity('The Pirate Bay'));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1337x',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: appController.is1337XEnabled,
                    onChanged: (value) {
                      value
                          ? appController.enableUsecase(UsecaseEntity('1337x'))
                          : appController.disableUsecase<
                              GetMagnetLinksFrom1337X>(UsecaseEntity('1337x'));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nyaa',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: appController.isNyaaEnabled,
                    onChanged: (value) {
                      value
                          ? appController.enableUsecase(UsecaseEntity('Nyaa'))
                          : appController.disableUsecase<
                              GetMagnetLinksFromNyaa>(UsecaseEntity('Nyaa'));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EZTV',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: appController.isEZTVEnabled,
                    onChanged: (value) {
                      value
                          ? appController.enableUsecase(UsecaseEntity('EZTV'))
                          : appController.disableUsecase<
                              GetMagnetLinksFromEZTV>(UsecaseEntity('EZTV'));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
