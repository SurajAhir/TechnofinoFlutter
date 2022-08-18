
import 'package:freezed_annotation/freezed_annotation.dart';

import '../login_response/TypeData.dart';

part 'Nodes.g.dart';
part 'Nodes.freezed.dart';
@Freezed()
class Nodes with _$Nodes{
  const factory Nodes(
  {
     @Default("")String title,
     @Default("")String view_url,
    required TypeData type_data,
    @Default(0)int parent_node_id,
     @Default("")String description,
    @Default(0)int node_id
}
      )=_Nodes;

  factory Nodes.fromJson(Map<String, dynamic> json
      )
  =>

      _$NodesFromJson(json);
}