// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FilterData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ThreadResponse _$$_ThreadResponseFromJson(Map<String, dynamic> json) =>
    _$_ThreadResponse(
      exact: json['exact'] == null
          ? null
          : UserData.fromJson(json['exact'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ThreadResponseToJson(_$_ThreadResponse instance) =>
    <String, dynamic>{
      'exact': instance.exact,
      'recommendations': instance.recommendations,
    };
