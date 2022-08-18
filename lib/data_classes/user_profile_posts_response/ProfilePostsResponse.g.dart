// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfilePostsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProfilePostsResponse _$$_ProfilePostsResponseFromJson(
        Map<String, dynamic> json) =>
    _$_ProfilePostsResponse(
      profile_posts: (json['profile_posts'] as List<dynamic>)
          .map((e) => ProfilePosts.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ProfilePostsResponseToJson(
        _$_ProfilePostsResponse instance) =>
    <String, dynamic>{
      'profile_posts': instance.profile_posts,
      'pagination': instance.pagination,
    };
