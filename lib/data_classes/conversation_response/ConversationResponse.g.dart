// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConversationResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConversationResponse _$$_ConversationResponseFromJson(
        Map<String, dynamic> json) =>
    _$_ConversationResponse(
      conversations: (json['conversations'] as List<dynamic>)
          .map((e) => Conversations.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ConversationResponseToJson(
        _$_ConversationResponse instance) =>
    <String, dynamic>{
      'conversations': instance.conversations,
      'pagination': instance.pagination,
    };
