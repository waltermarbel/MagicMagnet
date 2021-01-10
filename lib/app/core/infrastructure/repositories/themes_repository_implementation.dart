import 'package:dartz/dartz.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

import '../../domain/repositories/themes_repository.dart';
import '../../error/exceptions.dart';
import '../../error/failures.dart';
import '../../utils/user_interface/themes.dart';
import '../datasources/themes_datasource.dart';

class ThemesRepositoryImplementation implements ThemesRepository {
  final ThemesDataSource dataSource;

  ThemesRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, Themes>> getPreferredTheme() async {
    try {
      final usecases = await dataSource.getPreferredTheme();
      return right(usecases);
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setPreferredTheme(
      Themes newPreferredTheme) async {
    try {
      final usecase = await dataSource.setPreferredTheme(newPreferredTheme);
      return right(usecase);
    } on UnsupportedPlatformException {
      return left(UnsupportedPlatformFailure());
    }
  }
}
