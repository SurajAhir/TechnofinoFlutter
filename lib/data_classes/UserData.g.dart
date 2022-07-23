// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => _$_UserData(
      about: json['about'] as String? ?? "",
      register_date: (json['register_date'] as num?)?.toDouble() ?? 0,
      timezone: json['timezone'] as String? ?? "",
      user_group_id: json['user_group_id'] as int? ?? 0,
      user_id: json['user_id'] as int? ?? 0,
      username: json['username'] as String? ?? "",
      view_url: json['view_url'] as String? ?? "",
      message_count: json['message_count'] as int? ?? 0,
      reaction_score: json['reaction_score'] as int? ?? 0,
      trophy_points: json['trophy_points'] as int? ?? 0,
      user_title: json['user_title'] as String? ?? "",
      last_activity: (json['last_activity'] as num?)?.toDouble() ?? 0,
      avatar_urls:
          Avatar_Urls.fromJson(json['avatar_urls'] as Map<String, dynamic>),
      email: json['email'] as String? ?? "",
      show_dob_date: json['show_dob_date'] as bool? ?? false,
      show_dob_year: json['show_dob_year'] as bool? ?? false,
      receive_admin_email: json['receive_admin_email'] as bool? ?? false,
      website: json['website'] as String? ?? "",
      location: json['location'] as String? ?? "",
      activity_visible: json['activity_visible'] as bool? ?? false,
      allow_post_profile: json['allow_post_profile'] as String? ?? "",
      allow_receive_news_feed: json['allow_receive_news_feed'] as String? ?? "",
      allow_send_personal_conversation:
          json['allow_send_personal_conversation'] as String? ?? "",
      allow_view_identities: json['allow_view_identities'] as String? ?? "",
      allow_view_profile: json['allow_view_profile'] as String? ?? "",
      visible: json['visible'] as bool? ?? false,
      can_converse: json['can_converse'] as bool? ?? false,
      can_post_profile: json['can_post_profile'] as bool? ?? false,
      can_view_profile: json['can_view_profile'] as bool? ?? false,
      can_view_profile_posts: json['can_view_profile_posts'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'about': instance.about,
      'register_date': instance.register_date,
      'timezone': instance.timezone,
      'user_group_id': instance.user_group_id,
      'user_id': instance.user_id,
      'username': instance.username,
      'view_url': instance.view_url,
      'message_count': instance.message_count,
      'reaction_score': instance.reaction_score,
      'trophy_points': instance.trophy_points,
      'user_title': instance.user_title,
      'last_activity': instance.last_activity,
      'avatar_urls': instance.avatar_urls,
      'email': instance.email,
      'show_dob_date': instance.show_dob_date,
      'show_dob_year': instance.show_dob_year,
      'receive_admin_email': instance.receive_admin_email,
      'website': instance.website,
      'location': instance.location,
      'activity_visible': instance.activity_visible,
      'allow_post_profile': instance.allow_post_profile,
      'allow_receive_news_feed': instance.allow_receive_news_feed,
      'allow_send_personal_conversation':
          instance.allow_send_personal_conversation,
      'allow_view_identities': instance.allow_view_identities,
      'allow_view_profile': instance.allow_view_profile,
      'visible': instance.visible,
      'can_converse': instance.can_converse,
      'can_post_profile': instance.can_post_profile,
      'can_view_profile': instance.can_view_profile,
      'can_view_profile_posts': instance.can_view_profile_posts,
    };
