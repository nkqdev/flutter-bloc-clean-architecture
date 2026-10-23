import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_info_model.freezed.dart';
part 'auth_info_model.g.dart';

@freezed
abstract class AuthInfoModel with _$AuthInfoModel {
  const factory AuthInfoModel({
    String? accessToken,
    String? refreshToken,
    String? tokenType,
    int? expiresIn,
  }) = _AuthInfoModel;

  factory AuthInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AuthInfoModelFromJson(json);
}
