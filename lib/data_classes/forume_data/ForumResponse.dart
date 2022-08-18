import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/forume_data/ForumData.dart';


part 'ForumResponse.freezed.dart';
part 'ForumResponse.g.dart';
@Freezed()
class ForumResponse with _$ForumResponse {
  const factory ForumResponse(
      {
        List<ForumData>? breadcrumbs,
      @Default("")String title,
      @Default("")String description}) = _ForumResponse;

  factory ForumResponse.fromJson(Map<String, dynamic> json) =>
      _$ForumResponseFromJson(json);
}
