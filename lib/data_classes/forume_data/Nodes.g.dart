// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Nodes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Nodes _$$_NodesFromJson(Map<String, dynamic> json) => _$_Nodes(
      title: json['title'] as String? ?? "",
      view_url: json['view_url'] as String? ?? "",
      type_data: TypeData.fromJson(json['type_data'] as Map<String, dynamic>),
      parent_node_id: json['parent_node_id'] as int? ?? 0,
      description: json['description'] as String? ?? "",
      node_id: json['node_id'] as int? ?? 0,
    );

Map<String, dynamic> _$$_NodesToJson(_$_Nodes instance) => <String, dynamic>{
      'title': instance.title,
      'view_url': instance.view_url,
      'type_data': instance.type_data,
      'parent_node_id': instance.parent_node_id,
      'description': instance.description,
      'node_id': instance.node_id,
    };
