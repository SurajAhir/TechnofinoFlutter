// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ForumResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ForumResponse _$$_ForumResponseFromJson(Map<String, dynamic> json) =>
    _$_ForumResponse(
      breadcrumbs: (json['breadcrumbs'] as List<dynamic>?)
          ?.map((e) => ForumData.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$$_ForumResponseToJson(_$_ForumResponse instance) =>
    <String, dynamic>{
      'breadcrumbs': instance.breadcrumbs,
      'title': instance.title,
      'description': instance.description,
    };
