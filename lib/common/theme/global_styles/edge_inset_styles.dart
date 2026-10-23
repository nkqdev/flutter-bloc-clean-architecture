import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/app_scale.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/dimension.dart';

/// Paddings and margins. Getters for the same reason as [SizedBoxStyles].
class EdgeInsetStyles {
  static EdgeInsets get allXSmall => _all(Dimension.spaceXSmall);
  static EdgeInsets get allSmall => _all(Dimension.spaceSmall);
  static EdgeInsets get allMedium => _all(Dimension.spaceMedium);
  static EdgeInsets get allLarge => _all(Dimension.spaceLarge);
  static EdgeInsets get allXLarge => _all(Dimension.spaceXLarge);
  static EdgeInsets get allHuge => _all(Dimension.spaceHuge);

  static EdgeInsets get horizontalXSmall => _horizontal(Dimension.spaceXSmall);
  static EdgeInsets get horizontalSmall => _horizontal(Dimension.spaceSmall);
  static EdgeInsets get horizontalMedium => _horizontal(Dimension.spaceMedium);
  static EdgeInsets get horizontalLarge => _horizontal(Dimension.spaceLarge);
  static EdgeInsets get horizontalXLarge => _horizontal(Dimension.spaceXLarge);

  static EdgeInsets get verticalXSmall => _vertical(Dimension.spaceXSmall);
  static EdgeInsets get verticalSmall => _vertical(Dimension.spaceSmall);
  static EdgeInsets get verticalMedium => _vertical(Dimension.spaceMedium);
  static EdgeInsets get verticalLarge => _vertical(Dimension.spaceLarge);
  static EdgeInsets get verticalXLarge => _vertical(Dimension.spaceXLarge);

  /// Standard page padding.
  static EdgeInsets get scaffold => EdgeInsets.symmetric(
    horizontal: AppScale.w(Dimension.scaffoldHorizontal),
    vertical: AppScale.h(Dimension.scaffoldVertical),
  );
  static EdgeInsets get scaffoldHorizontal =>
      _horizontal(Dimension.scaffoldHorizontal);
  static EdgeInsets get scaffoldVertical =>
      _vertical(Dimension.scaffoldVertical);

  static EdgeInsets _all(double value) => EdgeInsets.all(AppScale.r(value));

  static EdgeInsets _horizontal(double value) =>
      EdgeInsets.symmetric(horizontal: AppScale.w(value));

  static EdgeInsets _vertical(double value) =>
      EdgeInsets.symmetric(vertical: AppScale.h(value));
}
