import '../../../../core/utils/user_interface/themes.dart';

extension ThemeName on Themes {
  String get name {
    switch (this) {
      case Themes.dark:
        return 'Dark';
      case Themes.light:
        return 'Light';
      default:
        return 'Undefined';
    }
  }
}
