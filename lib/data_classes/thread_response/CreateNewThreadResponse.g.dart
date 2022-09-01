// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreateNewThreadResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreateNewThreadResponse _$$_CreateNewThreadResponseFromJson(
        Map<String, dynamic> json) =>
    _$_CreateNewThreadResponse(
      thread: Threads.fromJson(json['thread'] as Map<String, dynamic>),
      success: json['success'] as bool? ?? false,
    );

Map<String, dynamic> _$$_CreateNewThreadResponseToJson(
        _$_CreateNewThreadResponse instance) =>
    <String, dynamic>{
      'thread': instance.thread,
      'success': instance.success,
    };
