// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThreadResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ThreadResponse _$$_ThreadResponseFromJson(Map<String, dynamic> json) =>
    _$_ThreadResponse(
      threads: (json['threads'] as List<dynamic>)
          .map((e) => Threads.fromJson(e as Map<String, dynamic>))
          .toList(),
      sticky: (json['sticky'] as List<dynamic>?)
          ?.map((e) => Threads.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ThreadResponseToJson(_$_ThreadResponse instance) =>
    <String, dynamic>{
      'threads': instance.threads,
      'sticky': instance.sticky,
      'pagination': instance.pagination,
    };
