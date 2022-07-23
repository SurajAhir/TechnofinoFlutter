import 'package:freezed_annotation/freezed_annotation.dart';
part 'Pagination.g.dart';

part 'Pagination.freezed.dart';
@Freezed()
class Pagination
with _$Pagination{

const factory Pagination
(
{
@Default(0)int current_page,
@Default(0)int last_page,
@Default(0)int per_page,
@Default(0)int total
}
)
=
_Pagination;

factory
Pagination.fromJson(

Map<String, dynamic> json
)
=>

_$PaginationFromJson(json);}