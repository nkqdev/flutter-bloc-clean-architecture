/// Relative API endpoints. Group by service, keep paths in one place.
class ApiEndpointsConstant {
  // Auth
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';

  // User
  static const String users = '/users';
  static const String userDetail = '/users/{id}';
  static const String userProfile = '/users/me';
}
