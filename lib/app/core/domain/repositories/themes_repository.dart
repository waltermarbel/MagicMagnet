import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../utils/user_interface/themes.dart';

abstract class ThemesRepository {
  Future<Either<Failure, Themes>> getPreferredTheme();
  Future<Either<Failure, void>> setPreferredTheme(Themes newPreferredTheme);
}
