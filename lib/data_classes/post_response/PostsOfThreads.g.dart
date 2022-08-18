// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostsOfThreads.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostsOfThreads _$$_PostsOfThreadsFromJson(Map<String, dynamic> json) =>
    _$_PostsOfThreads(
      message: json['message'] as String? ?? "",
      message_parsed: json['message_parsed'] as String? ?? "",
      Thread: json['Thread'] == null
          ? null
          : Threads.fromJson(json['Thread'] as Map<String, dynamic>),
      position: json['position'] as int? ?? 0,
      message_date: (json['message_date'] as num?)?.toDouble() ?? 0,
      post_date: (json['post_date'] as num?)?.toDouble() ?? 0,
      thread_id: json['thread_id'] as int? ?? 0,
      user_id: json['user_id'] as int? ?? 0,
      post_id: json['post_id'] as int? ?? 0,
      is_reacted_to: json['is_reacted_to'] as bool? ?? false,
      visitor_reaction_id: json['visitor_reaction_id'] as int? ?? 0,
      reaction_score: json['reaction_score'] as int? ?? 0,
      User: json['User'] == null
          ? null
          : UserData.fromJson(json['User'] as Map<String, dynamic>),
      tapi_reactions: (json['tapi_reactions'] as List<dynamic>?)
          ?.map((e) => TapiReaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      conversation_id: json['conversation_id'] as int? ?? 0,
      message_id: json['message_id'] as int? ?? 0,
      attach_count: json['attach_count'] as int? ?? 0,
      is_staff: json['is_staff'] as bool? ?? false,
      is_admin: json['is_admin'] as bool? ?? false,
      is_super_admin: json['is_super_admin'] as bool? ?? false,
      Attachments: (json['Attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      view_url: json['view_url'] as String? ?? "",
      message_state: json['message_state'] as String? ?? "",
    );

Map<String, dynamic> _$$_PostsOfThreadsToJson(_$_PostsOfThreads instance) =>
    <String, dynamic>{
      'message': instance.message,
      'message_parsed': instance.message_parsed,
      'Thread': instance.Thread,
      'position': instance.position,
      'message_date': instance.message_date,
      'post_date': instance.post_date,
      'thread_id': instance.thread_id,
      'user_id': instance.user_id,
      'post_id': instance.post_id,
      'is_reacted_to': instance.is_reacted_to,
      'visitor_reaction_id': instance.visitor_reaction_id,
      'reaction_score': instance.reaction_score,
      'User': instance.User,
      'tapi_reactions': instance.tapi_reactions,
      'conversation_id': instance.conversation_id,
      'message_id': instance.message_id,
      'attach_count': instance.attach_count,
      'is_staff': instance.is_staff,
      'is_admin': instance.is_admin,
      'is_super_admin': instance.is_super_admin,
      'Attachments': instance.Attachments,
      'view_url': instance.view_url,
      'message_state': instance.message_state,
    };
