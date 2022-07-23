import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreads.dart';

import '../pagination/Pagination.dart';
part 'PostsOfThreadResponse.freezed.dart';
part 'PostsOfThreadResponse.g.dart';
@Freezed()
class PostsOfThreadResponse with _$PostsOfThreadResponse {
  const factory PostsOfThreadResponse(
      {
        required List<PostsOfThreads> posts,
        Pagination? pagination}) = _PostsOfThreadResponse;

  factory PostsOfThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$PostsOfThreadResponseFromJson(json);
}
