
import 'package:freezed_annotation/freezed_annotation.dart';

import '../pagination/Pagination.dart';
import '../post_response/PostsOfThreads.dart';
part 'ProfilePostsResponse.g.dart';
part 'ProfilePostsResponse.freezed.dart';
@Freezed()
class ProfilePostsResponse with _$ProfilePostsResponse{
  const factory ProfilePostsResponse({
    required List<PostsOfThreads> profile_posts,
    Pagination? pagination
})= _ProfilePostsResponse;

  factory ProfilePostsResponse.fromJson(Map<String,dynamic> json)=> _$ProfilePostsResponseFromJson(json);
}