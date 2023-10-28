import 'package:actual/model/restaurant_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cusor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true // <T> 제너릭을 쓸려면 여기서 true 라고 넣어줘야한다 .
)
class CursorPagination<T> {
  late final CursorPaginationMeta meta;
  late final List<T> data;

  CursorPagination({
   required this.data,
   required this.meta, 
  });
  
  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT)
  => _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count, 
    required this.hasMore
  });
  
  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json)
  => _$CursorPaginationMetaFromJson(json);
}
