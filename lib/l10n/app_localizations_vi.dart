// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Flutter BLoC Clean Architecture';

  @override
  String get home => 'Trang chủ';

  @override
  String get users => 'Người dùng';

  @override
  String get login => 'Đăng nhập';

  @override
  String get loginTitle => 'Chào mừng trở lại';

  @override
  String get loginSubtitle => 'Đăng nhập để tiếp tục';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get username => 'Tên đăng nhập';

  @override
  String get password => 'Mật khẩu';

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get version => 'Phiên bản';

  @override
  String get retry => 'Thử lại';

  @override
  String get emptyData => 'Không có dữ liệu';

  @override
  String get errorConnection =>
      'Không thể kết nối tới máy chủ. Vui lòng kiểm tra mạng.';

  @override
  String get errorTimeout => 'Yêu cầu quá thời gian. Vui lòng thử lại.';

  @override
  String get errorUnauthorized =>
      'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';

  @override
  String get errorForbidden => 'Bạn không có quyền thực hiện thao tác này.';

  @override
  String get errorNotFound => 'Không tìm thấy dữ liệu yêu cầu.';

  @override
  String get errorServer => 'Lỗi máy chủ. Vui lòng thử lại sau.';

  @override
  String get errorUnknown => 'Đã có lỗi xảy ra. Vui lòng thử lại.';
}
