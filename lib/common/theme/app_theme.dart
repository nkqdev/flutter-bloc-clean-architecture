import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/dimension.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/global_styles/index.dart';

/// Colors come from Flutter's default Material 3 color scheme (baseline
/// purple, primary `#6750A4`). Only shapes, text scale and component details
/// are customized here.
///
/// To switch to a brand color later, replace [_defaultScheme] with
/// `ColorScheme.fromSeed(seedColor: AppColors.primaryColor, brightness: ...)`
/// and update the splash colors in `pubspec.yaml`.
class AppTheme {
  static ThemeData get lightTheme => _build(Brightness.light);

  static ThemeData get darkTheme => _build(Brightness.dark);

  static ColorScheme _defaultScheme(Brightness brightness) =>
      ThemeData(useMaterial3: true, brightness: brightness).colorScheme;

  static ThemeData _build(Brightness brightness) {
    final colorScheme = _defaultScheme(brightness);
    final textStyles = TextStyles.withColor(colorScheme.onSurface);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textStyles.toTextTheme(),
      extensions: [textStyles],
      appBarTheme: AppBarTheme(
        elevation: Dimension.zero.toDouble(),
        scrolledUnderElevation: Dimension.zero.toDouble(),
        centerTitle: true,
      ),
      dividerTheme: const DividerThemeData(
        thickness: Dimension.dividerThickness,
        space: Dimension.dividerThickness,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(borderRadius: RadiusStyles.mediumBorder),
      ),
    );
  }
}
