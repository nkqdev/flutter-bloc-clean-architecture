import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/app_scale.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/dimension.dart';

/// Text styles h0..h6, provided by the theme so they follow light/dark mode.
///
/// Usage: `context.textStyles.h1` (or `TextStyles.of(context).h1`).
/// Registered in `AppTheme` as a [ThemeExtension] and also mapped onto the
/// Material [TextTheme], so plain `Text` widgets get the same look.
@immutable
class TextStyles extends ThemeExtension<TextStyles> {
  final TextStyle h0;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;

  const TextStyles({
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
  });

  /// Built by `AppTheme` with `colorScheme.onSurface`.
  factory TextStyles.withColor(Color color) {
    TextStyle style(double size, FontWeight weight) => TextStyle(
      fontSize: AppScale.sp(size),
      fontWeight: weight,
      color: color,
    );

    return TextStyles(
      h0: style(Dimension.fontH0, FontWeight.w700),
      h1: style(Dimension.fontH1, FontWeight.w700),
      h2: style(Dimension.fontH2, FontWeight.w700),
      h3: style(Dimension.fontH3, FontWeight.w600),
      h4: style(Dimension.fontH4, FontWeight.w600),
      h5: style(Dimension.fontH5, FontWeight.w400),
      h6: style(Dimension.fontH6, FontWeight.w400),
    );
  }

  static TextStyles of(BuildContext context) =>
      Theme.of(context).extension<TextStyles>()!;

  /// Same scale exposed through Material's names.
  TextTheme toTextTheme() {
    return TextTheme(
      displaySmall: h0,
      headlineLarge: h1,
      headlineMedium: h2,
      titleLarge: h3,
      titleMedium: h4,
      bodyLarge: h5,
      bodyMedium: h6,
      labelLarge: h6.copyWith(fontWeight: FontWeight.w600),
    );
  }

  @override
  TextStyles copyWith({
    TextStyle? h0,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? h6,
  }) {
    return TextStyles(
      h0: h0 ?? this.h0,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
    );
  }

  @override
  TextStyles lerp(TextStyles? other, double t) {
    if (other == null) return this;
    return TextStyles(
      h0: TextStyle.lerp(h0, other.h0, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      h4: TextStyle.lerp(h4, other.h4, t)!,
      h5: TextStyle.lerp(h5, other.h5, t)!,
      h6: TextStyle.lerp(h6, other.h6, t)!,
    );
  }
}

extension TextStylesContext on BuildContext {
  TextStyles get textStyles => TextStyles.of(this);
}
