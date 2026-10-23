import 'package:package_info_plus/package_info_plus.dart';

/// App information (name, version, build number) loaded once at startup.
class AppUtils {
  static final AppUtils _instance = AppUtils._internal();
  AppUtils._internal();

  factory AppUtils() => _instance;

  static late PackageInfo packageInfo;

  static String get version =>
      '${packageInfo.version} (${packageInfo.buildNumber})';

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
