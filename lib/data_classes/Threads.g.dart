// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Threads.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Threads _$$_ThreadsFromJson(Map<String, dynamic> json) => _$_Threads(
      last_post_username: json['last_post_username'] as String? ?? "",
      title: json['title'] as String? ?? "",
      reply_count: json['reply_count'] as int? ?? 0,
      post_date: (json['post_date'] as num?)?.toDouble() ?? 0,
      User: UserData.fromJson(json['User'] as Map<String, dynamic>),
      thread_id: json['thread_id'] as int? ?? 0,
      last_post_date: (json['last_post_date'] as num?)?.toDouble() ?? 0,
      username: json['username'] as String? ?? "",
      view_count: json['view_count'] as int? ?? 0,
      Forum: json['Forum'] == null
          ? null
          : ForumResponse.fromJson(json['Forum'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ThreadsToJson(_$_Threads instance) =>
    <String, dynamic>{
      'last_post_username': instance.last_post_username,
      'title': instance.title,
      'reply_count': instance.reply_count,
      'post_date': instance.post_date,
      'User': instance.User,
      'thread_id': instance.thread_id,
      'last_post_date': instance.last_post_date,
      'username': instance.username,
      'view_count': instance.view_count,
      'Forum': instance.Forum,
    };
