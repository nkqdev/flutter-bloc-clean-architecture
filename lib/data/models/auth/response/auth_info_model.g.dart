// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthInfoModel _$AuthInfoModelFromJson(Map<String, dynamic> json) =>
    _AuthInfoModel(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      tokenType: json['tokenType'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthInfoModelToJson(_AuthInfoModel instance) =>
    <String, dynamic>{
      if (instance.accessToken case final value?) 'accessToken': value,
      if (instance.refreshToken case final value?) 'refreshToken': value,
      if (instance.tokenType case final value?) 'tokenType': value,
      if (instance.expiresIn case final value?) 'expiresIn': value,
    };
