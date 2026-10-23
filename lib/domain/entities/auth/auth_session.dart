import 'package:meta/meta.dart';

@immutable
class AuthSession {
  final String accessToken;
  final String? refreshToken;
  final String tokenType;
  final int? expiresIn;

  const AuthSession({
    required this.accessToken,
    this.refreshToken,
    this.tokenType = 'Bearer',
    this.expiresIn,
  });

  String get authorizationHeader => '$tokenType $accessToken';
}
