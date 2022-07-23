// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TypeData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TypeData _$$_TypeDataFromJson(Map<String, dynamic> json) => _$_TypeData(
      last_post_date: (json['last_post_date'] as num?)?.toDouble() ?? 0,
      last_post_username: json['last_post_username'] as String? ?? "",
      last_thread_id: json['last_thread_id'] as int? ?? 0,
      last_thread_title: json['last_thread_title'] as String? ?? "",
      message_count: json['message_count'] as int? ?? 0,
      discussion_count: json['discussion_count'] as int? ?? 0,
      allow_posting: json['allow_posting'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TypeDataToJson(_$_TypeData instance) =>
    <String, dynamic>{
      'last_post_date': instance.last_post_date,
      'last_post_username': instance.last_post_username,
      'last_thread_id': instance.last_thread_id,
      'last_thread_title': instance.last_thread_title,
      'message_count': instance.message_count,
      'discussion_count': instance.discussion_count,
      'allow_posting': instance.allow_posting,
    };
