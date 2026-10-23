import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/dimension.dart';

/// Corner radii. Never scaled, so everything here is `const`.
class RadiusStyles {
  static const Radius roundRadius = Radius.circular(Dimension.radiusRound);
  static const Radius largeRadius = Radius.circular(Dimension.radiusLarge);
  static const Radius mediumRadius = Radius.circular(Dimension.radiusMedium);
  static const Radius smallRadius = Radius.circular(Dimension.radiusSmall);

  static const BorderRadius roundBorder = BorderRadius.all(roundRadius);
  static const BorderRadius largeBorder = BorderRadius.all(largeRadius);
  static const BorderRadius mediumBorder = BorderRadius.all(mediumRadius);
  static const BorderRadius smallBorder = BorderRadius.all(smallRadius);
}
