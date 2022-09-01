// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfilePosts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProfilePosts _$$_ProfilePostsFromJson(Map<String, dynamic> json) =>
    _$_ProfilePosts(
      message: json['message'] as String? ?? "",
      message_parsed: json['message_parsed'] as String? ?? "",
      position: json['position'] as int? ?? 0,
      LatestComments: (json['LatestComments'] as List<dynamic>?)
          ?.map((e) => ProfilePosts.fromJson(e as Map<String, dynamic>))
          .toList(),
      comment_count: json['comment_count'] as int? ?? 0,
      post_date: (json['post_date'] as num?)?.toDouble() ?? 0,
      comment_date: (json['comment_date'] as num?)?.toDouble() ?? 0,
      profile_user_id: json['profile_user_id'] as int? ?? 0,
      profile_post_id: json['profile_post_id'] as int? ?? 0,
      is_reacted_to: json['is_reacted_to'] as bool? ?? false,
      visitor_reaction_id: json['visitor_reaction_id'] as int? ?? 0,
      reaction_score: json['reaction_score'] as int? ?? 0,
      User: json['User'] == null
          ? null
          : UserData.fromJson(json['User'] as Map<String, dynamic>),
      tapi_reactions: (json['tapi_reactions'] as List<dynamic>?)
          ?.map((e) => TapiReaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      attach_count: json['attach_count'] as int? ?? 0,
      Attachments: (json['Attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      view_url: json['view_url'] as String? ?? "",
      profile_post_comment_id: json['profile_post_comment_id'] as int? ?? 0,
    );

Map<String, dynamic> _$$_ProfilePostsToJson(_$_ProfilePosts instance) =>
    <String, dynamic>{
      'message': instance.message,
      'message_parsed': instance.message_parsed,
      'position': instance.position,
      'LatestComments': instance.LatestComments,
      'comment_count': instance.comment_count,
      'post_date': instance.post_date,
      'comment_date': instance.comment_date,
      'profile_user_id': instance.profile_user_id,
      'profile_post_id': instance.profile_post_id,
      'is_reacted_to': instance.is_reacted_to,
      'visitor_reaction_id': instance.visitor_reaction_id,
      'reaction_score': instance.reaction_score,
      'User': instance.User,
      'tapi_reactions': instance.tapi_reactions,
      'attach_count': instance.attach_count,
      'Attachments': instance.Attachments,
      'view_url': instance.view_url,
      'profile_post_comment_id': instance.profile_post_comment_id,
    };
