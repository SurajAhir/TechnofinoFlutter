// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Conversations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Conversations _$$_ConversationsFromJson(Map<String, dynamic> json) =>
    _$_Conversations(
      conversation_id: json['conversation_id'] as int? ?? 0,
      first_message_id: json['first_message_id'] as int? ?? 0,
      last_message_date: (json['last_message_date'] as num?)?.toDouble() ?? 0,
      last_message_id: json['last_message_id'] as int? ?? 0,
      last_message_user_id: json['last_message_user_id'] as int? ?? 0,
      recipient_count: json['recipient_count'] as int? ?? 0,
      start_date: (json['start_date'] as num?)?.toDouble() ?? 0,
      reply_count: json['reply_count'] as int? ?? 0,
      Starter: json['Starter'] == null
          ? null
          : UserData.fromJson(json['Starter'] as Map<String, dynamic>),
      title: json['title'] as String? ?? "",
      user_id: json['user_id'] as int? ?? 0,
      username: json['username'] as String? ?? "",
      view_url: json['view_url'] as String? ?? "",
      is_starred: json['is_starred'] as bool? ?? false,
      is_unread: json['is_unread'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ConversationsToJson(_$_Conversations instance) =>
    <String, dynamic>{
      'conversation_id': instance.conversation_id,
      'first_message_id': instance.first_message_id,
      'last_message_date': instance.last_message_date,
      'last_message_id': instance.last_message_id,
      'last_message_user_id': instance.last_message_user_id,
      'recipient_count': instance.recipient_count,
      'start_date': instance.start_date,
      'reply_count': instance.reply_count,
      'Starter': instance.Starter,
      'title': instance.title,
      'user_id': instance.user_id,
      'username': instance.username,
      'view_url': instance.view_url,
      'is_starred': instance.is_starred,
      'is_unread': instance.is_unread,
    };
