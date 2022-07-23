
import 'package:freezed_annotation/freezed_annotation.dart';

import 'Nodes.dart';
part 'NodeResponse.g.dart';
part 'NodeResponse.freezed.dart';
@Freezed()
class NodeResponse with _$NodeResponse{
  const factory NodeResponse(
      {
         required List<Nodes> nodes,
        Map<String, List<int>>? tree_map
      }
      )=_NodeResponse;

  factory NodeResponse.fromJson(Map<String, dynamic> json
      )
  =>

      _$NodeResponseFromJson(json);
}