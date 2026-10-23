import 'package:meta/meta.dart';

@immutable
class Paginated<T> {
  static const int firstPage = 1;
  static const int defaultPageSize = 20;

  final List<T> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;

  const Paginated({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
  });

  bool get hasNextPage => pageNumber * pageSize < totalCount;
}
