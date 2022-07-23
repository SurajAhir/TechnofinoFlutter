// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThreadFromPost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ThreadFromPost _$$_ThreadFromPostFromJson(Map<String, dynamic> json) =>
    _$_ThreadFromPost(
      Thread: Threads.fromJson(json['Thread'] as Map<String, dynamic>),
      position: json['position'] as int? ?? 0,
    );

Map<String, dynamic> _$$_ThreadFromPostToJson(_$_ThreadFromPost instance) =>
    <String, dynamic>{
      'Thread': instance.Thread,
      'position': instance.position,
    };
