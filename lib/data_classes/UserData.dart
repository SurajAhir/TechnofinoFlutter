import 'package:freezed_annotation/freezed_annotation.dart';

import 'Avatar_Urls.dart';

part 'UserData.freezed.dart';

part 'UserData.g.dart';

@Freezed()
class UserData with _$UserData {
  const factory UserData(
      {@Default("") String about,
      @Default(0) double register_date,
          @Default("") String timezone,
      @Default(0) int user_group_id,
      @Default(0) int user_id,
      @Default("") String username,
      @Default("") String view_url,
      @Default(0) int message_count,
      @Default(0) int reaction_score,
      @Default(0) int trophy_points,
      @Default("") String user_title,
      @Default(0) double last_activity,
       required Avatar_Urls avatar_urls,
      @Default("") String email,
      @Default(false) bool show_dob_date,
      @Default(false) bool show_dob_year,
      @Default(false) bool receive_admin_email,
      @Default("") String website,
      @Default("") String location,
      @Default(false) bool activity_visible,
      @Default("") String allow_post_profile,
      @Default("") String allow_receive_news_feed,
      @Default("") String allow_send_personal_conversation,
      @Default("") String allow_view_identities,
      @Default("") String allow_view_profile,
      @Default(false) bool visible,
      @Default(false) bool can_converse,
      @Default(false) bool can_post_profile,
      @Default(false) bool can_view_profile,
      @Default(false) bool can_view_profile_posts}) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
