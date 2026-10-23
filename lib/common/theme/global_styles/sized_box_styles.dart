import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/app_scale.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/dimension.dart';

/// Gaps between widgets.
///
/// Getters, not fields: each access reads the current screen size, so values
/// stay correct after rotation or window resize when scaling is on.
class SizedBoxStyles {
  static const SizedBox shrink = SizedBox.shrink();

  static SizedBox get horizontalXSmall => _width(Dimension.spaceXSmall);
  static SizedBox get horizontalSmall => _width(Dimension.spaceSmall);
  static SizedBox get horizontalMedium => _width(Dimension.spaceMedium);
  static SizedBox get horizontalLarge => _width(Dimension.spaceLarge);
  static SizedBox get horizontalXLarge => _width(Dimension.spaceXLarge);
  static SizedBox get horizontalHuge => _width(Dimension.spaceHuge);
  static SizedBox get horizontalMassive => _width(Dimension.spaceMassive);

  static SizedBox get verticalXSmall => _height(Dimension.spaceXSmall);
  static SizedBox get verticalSmall => _height(Dimension.spaceSmall);
  static SizedBox get verticalMedium => _height(Dimension.spaceMedium);
  static SizedBox get verticalLarge => _height(Dimension.spaceLarge);
  static SizedBox get verticalXLarge => _height(Dimension.spaceXLarge);
  static SizedBox get verticalHuge => _height(Dimension.spaceHuge);
  static SizedBox get verticalMassive => _height(Dimension.spaceMassive);

  static SizedBox _width(double value) => SizedBox(width: AppScale.w(value));

  static SizedBox _height(double value) => SizedBox(height: AppScale.h(value));
}
