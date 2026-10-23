import 'package:flutter_bloc_clean_architecture/data/models/auth/response/auth_info_model.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/auth/auth_session.dart';

extension AuthInfoModelMapper on AuthInfoModel {
  AuthSession toEntity() {
    return AuthSession(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken,
      tokenType: tokenType ?? 'Bearer',
      expiresIn: expiresIn,
    );
  }
}
