// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostsOfThreadResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostsOfThreadResponse _$$_PostsOfThreadResponseFromJson(
        Map<String, dynamic> json) =>
    _$_PostsOfThreadResponse(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PostsOfThreads.fromJson(e as Map<String, dynamic>))
          .toList(),
      pinned_post: json['pinned_post'] == null
          ? null
          : PostsOfThreads.fromJson(
              json['pinned_post'] as Map<String, dynamic>),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PostsOfThreadResponseToJson(
        _$_PostsOfThreadResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'pinned_post': instance.pinned_post,
      'pagination': instance.pagination,
    };
