// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PostsOfThreadResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostsOfThreadResponse _$PostsOfThreadResponseFromJson(
    Map<String, dynamic> json) {
  return _PostsOfThreadResponse.fromJson(json);
}

/// @nodoc
mixin _$PostsOfThreadResponse {
  List<PostsOfThreads> get posts => throw _privateConstructorUsedError;
  PostsOfThreads? get pinned_post => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostsOfThreadResponseCopyWith<PostsOfThreadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostsOfThreadResponseCopyWith<$Res> {
  factory $PostsOfThreadResponseCopyWith(PostsOfThreadResponse value,
          $Res Function(PostsOfThreadResponse) then) =
      _$PostsOfThreadResponseCopyWithImpl<$Res>;
  $Res call(
      {List<PostsOfThreads> posts,
      PostsOfThreads? pinned_post,
      Pagination? pagination});

  $PostsOfThreadsCopyWith<$Res>? get pinned_post;
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$PostsOfThreadResponseCopyWithImpl<$Res>
    implements $PostsOfThreadResponseCopyWith<$Res> {
  _$PostsOfThreadResponseCopyWithImpl(this._value, this._then);

  final PostsOfThreadResponse _value;
  // ignore: unused_field
  final $Res Function(PostsOfThreadResponse) _then;

  @override
  $Res call({
    Object? posts = freezed,
    Object? pinned_post = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      posts: posts == freezed
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostsOfThreads>,
      pinned_post: pinned_post == freezed
          ? _value.pinned_post
          : pinned_post // ignore: cast_nullable_to_non_nullable
              as PostsOfThreads?,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }

  @override
  $PostsOfThreadsCopyWith<$Res>? get pinned_post {
    if (_value.pinned_post == null) {
      return null;
    }

    return $PostsOfThreadsCopyWith<$Res>(_value.pinned_post!, (value) {
      return _then(_value.copyWith(pinned_post: value));
    });
  }

  @override
  $PaginationCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationCopyWith<$Res>(_value.pagination!, (value) {
      return _then(_value.copyWith(pagination: value));
    });
  }
}

/// @nodoc
abstract class _$$_PostsOfThreadResponseCopyWith<$Res>
    implements $PostsOfThreadResponseCopyWith<$Res> {
  factory _$$_PostsOfThreadResponseCopyWith(_$_PostsOfThreadResponse value,
          $Res Function(_$_PostsOfThreadResponse) then) =
      __$$_PostsOfThreadResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<PostsOfThreads> posts,
      PostsOfThreads? pinned_post,
      Pagination? pagination});

  @override
  $PostsOfThreadsCopyWith<$Res>? get pinned_post;
  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$_PostsOfThreadResponseCopyWithImpl<$Res>
    extends _$PostsOfThreadResponseCopyWithImpl<$Res>
    implements _$$_PostsOfThreadResponseCopyWith<$Res> {
  __$$_PostsOfThreadResponseCopyWithImpl(_$_PostsOfThreadResponse _value,
      $Res Function(_$_PostsOfThreadResponse) _then)
      : super(_value, (v) => _then(v as _$_PostsOfThreadResponse));

  @override
  _$_PostsOfThreadResponse get _value =>
      super._value as _$_PostsOfThreadResponse;

  @override
  $Res call({
    Object? posts = freezed,
    Object? pinned_post = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$_PostsOfThreadResponse(
      posts: posts == freezed
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostsOfThreads>,
      pinned_post: pinned_post == freezed
          ? _value.pinned_post
          : pinned_post // ignore: cast_nullable_to_non_nullable
              as PostsOfThreads?,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostsOfThreadResponse implements _PostsOfThreadResponse {
  const _$_PostsOfThreadResponse(
      {required final List<PostsOfThreads> posts,
      this.pinned_post,
      this.pagination})
      : _posts = posts;

  factory _$_PostsOfThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$$_PostsOfThreadResponseFromJson(json);

  final List<PostsOfThreads> _posts;
  @override
  List<PostsOfThreads> get posts {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  final PostsOfThreads? pinned_post;
  @override
  final Pagination? pagination;

  @override
  String toString() {
    return 'PostsOfThreadResponse(posts: $posts, pinned_post: $pinned_post, pagination: $pagination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostsOfThreadResponse &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            const DeepCollectionEquality()
                .equals(other.pinned_post, pinned_post) &&
            const DeepCollectionEquality()
                .equals(other.pagination, pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_posts),
      const DeepCollectionEquality().hash(pinned_post),
      const DeepCollectionEquality().hash(pagination));

  @JsonKey(ignore: true)
  @override
  _$$_PostsOfThreadResponseCopyWith<_$_PostsOfThreadResponse> get copyWith =>
      __$$_PostsOfThreadResponseCopyWithImpl<_$_PostsOfThreadResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostsOfThreadResponseToJson(this);
  }
}

abstract class _PostsOfThreadResponse implements PostsOfThreadResponse {
  const factory _PostsOfThreadResponse(
      {required final List<PostsOfThreads> posts,
      final PostsOfThreads? pinned_post,
      final Pagination? pagination}) = _$_PostsOfThreadResponse;

  factory _PostsOfThreadResponse.fromJson(Map<String, dynamic> json) =
      _$_PostsOfThreadResponse.fromJson;

  @override
  List<PostsOfThreads> get posts;
  @override
  PostsOfThreads? get pinned_post;
  @override
  Pagination? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$_PostsOfThreadResponseCopyWith<_$_PostsOfThreadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
