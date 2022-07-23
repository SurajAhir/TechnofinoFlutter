// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NodeResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NodeResponse _$$_NodeResponseFromJson(Map<String, dynamic> json) =>
    _$_NodeResponse(
      nodes: (json['nodes'] as List<dynamic>)
          .map((e) => Nodes.fromJson(e as Map<String, dynamic>))
          .toList(),
      tree_map: (json['tree_map'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as int).toList()),
      ),
    );

Map<String, dynamic> _$$_NodeResponseToJson(_$_NodeResponse instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
      'tree_map': instance.tree_map,
    };
