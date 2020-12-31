import 'package:mobx/mobx.dart';

import '../../../core/presentation/controllers/app_controller.dart';

part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  final AppController _appController;

  _SettingsControllerBase(this._appController);
}
