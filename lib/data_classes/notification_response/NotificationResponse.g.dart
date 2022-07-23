// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationResponse _$$_NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationResponse(
      alerts: (json['alerts'] as List<dynamic>)
          .map((e) => NotificationsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NotificationResponseToJson(
        _$_NotificationResponse instance) =>
    <String, dynamic>{
      'alerts': instance.alerts,
      'pagination': instance.pagination,
    };
