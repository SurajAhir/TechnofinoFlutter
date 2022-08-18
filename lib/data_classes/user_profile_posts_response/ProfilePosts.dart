import 'package:freezed_annotation/freezed_annotation.dart';
import '../attachment_response/AttachmentsData.dart';
import '../login_response/UserData.dart';
import '../post_response/TapiReaction.dart';

part 'ProfilePosts.freezed.dart';

part 'ProfilePosts.g.dart';

@Freezed()
class ProfilePosts with _$ProfilePosts {
  const factory ProfilePosts({
    @Default("")String message,
    @Default("")String message_parsed,
    @Default(0)int position,
    List<ProfilePosts>? LatestComments,
    @Default(0)int comment_count,
    @Default(0)double post_date,
    @Default(0)int profile_user_id,
    @Default(0)int profile_post_id,
    @Default(false)bool is_reacted_to,
    @Default(0)int visitor_reaction_id,
    @Default(0)int reaction_score,
    UserData? User,
    List<TapiReaction>? tapi_reactions,
    @Default(0)int attach_count,
    List<AttachmentsData>? Attachments,
    @Default("")String view_url,
    @Default(0)int profile_post_comment_id
  })=_ProfilePosts;

  factory ProfilePosts.fromJson(Map<String, dynamic> json)=>_$ProfilePostsFromJson(json);
}
