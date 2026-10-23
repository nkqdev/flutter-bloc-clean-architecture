import 'package:flutter_bloc_clean_architecture/data/models/user/user_model.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/user/user.dart';

extension UserModelMapper on UserModel {
  User toEntity() {
    return User(
      id: id ?? '',
      fullName: fullName ?? '',
      email: email,
      phoneNumber: phoneNumber,
      avatar: avatar,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }
}
