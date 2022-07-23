// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationsData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationsData _$$_NotificationsDataFromJson(Map<String, dynamic> json) =>
    _$_NotificationsData(
      action: json['action'] as String? ?? "",
      alert_id: json['alert_id'] as int? ?? 0,
      alert_text: json['alert_text'] as String? ?? "",
      alerted_user_id: json['alerted_user_id'] as int? ?? 0,
      User: json['User'] == null
          ? null
          : UserData.fromJson(json['User'] as Map<String, dynamic>),
      event_date: (json['event_date'] as num?)?.toDouble() ?? 0,
      view_date: (json['view_date'] as num?)?.toDouble() ?? 0,
      content_id: json['content_id'] as int? ?? 0,
      read_date: (json['read_date'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_NotificationsDataToJson(
        _$_NotificationsData instance) =>
    <String, dynamic>{
      'action': instance.action,
      'alert_id': instance.alert_id,
      'alert_text': instance.alert_text,
      'alerted_user_id': instance.alerted_user_id,
      'User': instance.User,
      'event_date': instance.event_date,
      'view_date': instance.view_date,
      'content_id': instance.content_id,
      'read_date': instance.read_date,
    };
