/// Design tokens, in design pixels (the size on the design file).
///
/// Every value is `const`. Do not apply them directly when screen scaling may
/// be on: go through the styles in `common/theme/global_styles/`, which pass
/// them through [AppScale].
class Dimension {
  static const num zero = 0;

  // -----------------------------
  // SPACING (one scale for gaps and paddings)
  // -----------------------------
  static const double spaceXSmall = 4;
  static const double spaceSmall = 8;
  static const double spaceMedium = 12;
  static const double spaceLarge = 16;
  static const double spaceXLarge = 24;
  static const double spaceHuge = 32;
  static const double spaceMassive = 48;

  static const double scaffoldHorizontal = 20;
  static const double scaffoldVertical = 16;

  // -----------------------------
  // FONT SIZES
  // -----------------------------
  static const double fontH0 = 32;
  static const double fontH1 = 28;
  static const double fontH2 = 24;
  static const double fontH3 = 20;
  static const double fontH4 = 18;
  static const double fontH5 = 16;
  static const double fontH6 = 14;

  // -----------------------------
  // RADIUS
  // -----------------------------
  static const double radiusSmall = 5;
  static const double radiusMedium = 10;
  static const double radiusLarge = 20;
  static const double radiusRound = 180;

  // -----------------------------
  // ICON SIZES
  // -----------------------------
  static const double iconXSmall = 16;
  static const double iconSmall = 20;
  static const double iconMedium = 24;
  static const double iconLarge = 32;

  // -----------------------------
  // BORDER & DIVIDER
  // -----------------------------
  static const double borderWidthThin = 1;
  static const double borderWidth = 1.5;
  static const double dividerThickness = 0.5;

  // -----------------------------
  // OPACITY
  // -----------------------------
  static const double opacityValue = 0.2;

  // -----------------------------
  // COMPONENTS
  // -----------------------------
  static const double loadingSizeSmall = 20;
  static const double loadingSizeMedium = 30;
  static const double loadingSizeLarge = 40;
  static const double buttonHeight = 52;
}
