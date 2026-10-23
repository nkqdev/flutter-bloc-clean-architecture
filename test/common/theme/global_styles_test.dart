import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/app_scale.dart';
import 'package:flutter_bloc_clean_architecture/common/dimension/dimension.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/app_theme.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/colors.dart';
import 'package:flutter_bloc_clean_architecture/common/theme/global_styles/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('scaling is off by default, styles use raw design tokens', () {
    expect(AppScale.enabled, isFalse);
    expect(SizedBoxStyles.verticalLarge.height, Dimension.spaceLarge);
    expect(SizedBoxStyles.horizontalSmall.width, Dimension.spaceSmall);
    expect(EdgeInsetStyles.allMedium, const EdgeInsets.all(12));
    expect(
      EdgeInsetStyles.scaffold,
      const EdgeInsets.symmetric(
        horizontal: Dimension.scaffoldHorizontal,
        vertical: Dimension.scaffoldVertical,
      ),
    );
  });

  test('text styles are exposed through the Material text theme too', () {
    final styles = TextStyles.withColor(Colors.black);
    final textTheme = styles.toTextTheme();
    expect(textTheme.headlineLarge, styles.h1);
    expect(styles.h1.fontSize, Dimension.fontH1);
  });

  Future<TextStyles> pumpAndReadStyles(
    WidgetTester tester,
    ThemeData theme,
  ) async {
    late TextStyles styles;
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Builder(
          builder: (context) {
            styles = context.textStyles;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    // MaterialApp animates theme changes (through TextStyles.lerp).
    await tester.pumpAndSettle();
    return styles;
  }

  test('theme uses Flutter default Material 3 colors', () {
    expect(
      AppTheme.lightTheme.colorScheme.primary,
      ThemeData(useMaterial3: true).colorScheme.primary,
    );
    expect(AppTheme.lightTheme.colorScheme.primary, AppColors.primaryColor);
  });

  testWidgets('TextStyles follow light and dark theme', (tester) async {
    final light = await pumpAndReadStyles(tester, AppTheme.lightTheme);
    expect(light.h1.color, AppTheme.lightTheme.colorScheme.onSurface);

    final dark = await pumpAndReadStyles(tester, AppTheme.darkTheme);
    expect(dark.h1.color, AppTheme.darkTheme.colorScheme.onSurface);
    expect(dark.h6.color, AppTheme.darkTheme.colorScheme.onSurface);
    expect(dark.h1.color, isNot(light.h1.color));
  });
}
