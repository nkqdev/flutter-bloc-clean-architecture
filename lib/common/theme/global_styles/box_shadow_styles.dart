import 'package:flutter/widgets.dart';

/// Shadows. `const`: color is black at `Dimension.opacityValue` (20%) alpha.
class BoxShadowStyles {
  static const Color _shadowColor = Color(0x33000000);

  static const BoxShadow boxShadowBlack = BoxShadow(
    color: _shadowColor,
    offset: Offset(0, 2),
    blurRadius: 4,
    spreadRadius: 1,
  );

  static const BoxShadow buttonShadow = BoxShadow(
    color: _shadowColor,
    offset: Offset(0, 3),
    blurRadius: 5,
    spreadRadius: 3,
  );
}
