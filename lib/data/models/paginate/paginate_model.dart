import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_bloc_clean_architecture/domain/entities/common/paginated.dart';

part 'paginate_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginateModel<T> {
  final List<T>? items;
  final int? pageNumber;
  final int? pageSize;
  final int? totalCount;

  const PaginateModel({
    this.items,
    this.pageNumber,
    this.pageSize,
    this.totalCount,
  });

  factory PaginateModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginateModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginateModelToJson(this, toJsonT);

  Paginated<E> toEntity<E>(E Function(T item) mapper) {
    return Paginated<E>(
      items: (items ?? const []).map(mapper).toList(),
      pageNumber: pageNumber ?? 1,
      pageSize: pageSize ?? 0,
      totalCount: totalCount ?? 0,
    );
  }
}
