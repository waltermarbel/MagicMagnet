import '../../utils/user_interface/themes.dart';

abstract class ThemesDataSource {
  Future<Themes> getPreferredTheme();
  Future<void> setPreferredTheme(Themes newPreferredTheme);
}
