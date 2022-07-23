// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConversationMessages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationMessages _$$_ConversationMessagesFromJson(
        Map<String, dynamic> json) =>
    _$_ConversationMessages(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => PostsOfThreads.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ConversationMessagesToJson(
        _$_ConversationMessages instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'pagination': instance.pagination,
    };
