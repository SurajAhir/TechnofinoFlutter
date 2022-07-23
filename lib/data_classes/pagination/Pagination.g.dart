// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pagination _$$_PaginationFromJson(Map<String, dynamic> json) =>
    _$_Pagination(
      current_page: json['current_page'] as int? ?? 0,
      last_page: json['last_page'] as int? ?? 0,
      per_page: json['per_page'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );

Map<String, dynamic> _$$_PaginationToJson(_$_Pagination instance) =>
    <String, dynamic>{
      'current_page': instance.current_page,
      'last_page': instance.last_page,
      'per_page': instance.per_page,
      'total': instance.total,
    };
