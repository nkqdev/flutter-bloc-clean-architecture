// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter BLoC Clean Architecture';

  @override
  String get home => 'Home';

  @override
  String get users => 'Users';

  @override
  String get login => 'Sign in';

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get logout => 'Sign out';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get language => 'Language';

  @override
  String get version => 'Version';

  @override
  String get retry => 'Retry';

  @override
  String get emptyData => 'No data';

  @override
  String get errorConnection =>
      'Unable to connect to the server. Please check your network.';

  @override
  String get errorTimeout => 'The request timed out. Please try again.';

  @override
  String get errorUnauthorized =>
      'Your session has expired. Please sign in again.';

  @override
  String get errorForbidden =>
      'You do not have permission to perform this action.';

  @override
  String get errorNotFound => 'The requested resource was not found.';

  @override
  String get errorServer => 'Server error. Please try again later.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';
}
