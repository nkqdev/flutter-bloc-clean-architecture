import 'dart:ui';

import 'package:flutter_bloc_clean_architecture/common/constants/configs_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Optional screen scaling on top of `flutter_screenutil`.
///
/// Turn it on with `ENABLE_SCREEN_SCALING=true` in `env/*.json` for fixed
/// hardware (kiosk, POS). It is off by default for phone apps: Flutter logical
/// pixels are already density independent, and scaling would ignore the
/// user's font size setting.
///
/// Always call these from getters or `build`, never from a `static final`
/// field: the result depends on the current screen size.
class AppScale {
  static const bool enabled = ConfigsConstant.enableScreenScaling;

  static const Size designSize = Size(
    ConfigsConstant.designWidth,
    ConfigsConstant.designHeight,
  );

  /// Horizontal size (widths, horizontal gaps).
  static double w(double value) => enabled ? value.w : value;

  /// Vertical size (heights, vertical gaps).
  static double h(double value) => enabled ? value.h : value;

  /// Size that must stay square (paddings on all sides, icons).
  static double r(double value) => enabled ? value.r : value;

  /// Font size.
  static double sp(double value) => enabled ? value.sp : value;
}
