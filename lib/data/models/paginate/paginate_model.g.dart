// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginateModel<T> _$PaginateModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginateModel<T>(
  items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
  pageNumber: (json['pageNumber'] as num?)?.toInt(),
  pageSize: (json['pageSize'] as num?)?.toInt(),
  totalCount: (json['totalCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$PaginateModelToJson<T>(
  PaginateModel<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  if (instance.items?.map(toJsonT).toList() case final value?) 'items': value,
  if (instance.pageNumber case final value?) 'pageNumber': value,
  if (instance.pageSize case final value?) 'pageSize': value,
  if (instance.totalCount case final value?) 'totalCount': value,
};
