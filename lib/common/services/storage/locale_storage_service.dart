import 'package:flutter_bloc_clean_architecture/common/constants/storage_key_constant.dart';
import 'package:flutter_bloc_clean_architecture/common/enums/locale_enum.dart';
import 'package:flutter_bloc_clean_architecture/common/services/storage/base_storage_service.dart';

/// Language and theme preferences.
///
/// [load] is awaited once at startup (while the native splash is visible), so
/// blocs can read the cached values synchronously and the first frame already
/// has the right language and theme.
class LocaleStorageService extends BaseStorageService {
  static final LocaleStorageService _instance =
      LocaleStorageService._internal();
  LocaleStorageService._internal();

  factory LocaleStorageService() => _instance;

  /// Cached language code, used by interceptors without awaiting storage.
  static String locale = SupportLocale.vi.name;

  bool _isDarkTheme = false;

  String get languageCode => locale;

  bool get isDarkTheme => _isDarkTheme;

  Future<void> load() async {
    final (languageCode, theme) = await (
      storage.read(key: StorageKeyConstant.LANGUAGE),
      storage.read(key: StorageKeyConstant.THEME),
    ).wait;
    locale = languageCode ?? SupportLocale.vi.name;
    _isDarkTheme = theme == 'true';
  }

  Future<void> setLocale(String languageCode) async {
    locale = languageCode;
    await storage.write(key: StorageKeyConstant.LANGUAGE, value: languageCode);
  }

  Future<void> setTheme(bool isDarkTheme) async {
    _isDarkTheme = isDarkTheme;
    await storage.write(
      key: StorageKeyConstant.THEME,
      value: isDarkTheme.toString(),
    );
  }
}
