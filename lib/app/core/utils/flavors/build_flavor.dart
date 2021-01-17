import 'package:meta/meta.dart';

enum Flavor { paid, free }

class BuildFlavor {
  BuildFlavor._internal(this.flavor);

  static BuildFlavor get instance => _instance;
  static bool get isPaid => _instance.flavor == Flavor.paid;
  static bool get isFree => _instance.flavor == Flavor.free;

  final Flavor flavor;

  static BuildFlavor _instance;

  factory BuildFlavor({@required Flavor flavor}) {
    _instance ??= BuildFlavor._internal(flavor);
    return _instance;
  }
}
