// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ProfilePostsResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProfilePostsResponse _$ProfilePostsResponseFromJson(Map<String, dynamic> json) {
  return _ProfilePostsResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfilePostsResponse {
  List<ProfilePosts> get profile_posts => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfilePostsResponseCopyWith<ProfilePostsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfilePostsResponseCopyWith<$Res> {
  factory $ProfilePostsResponseCopyWith(ProfilePostsResponse value,
          $Res Function(ProfilePostsResponse) then) =
      _$ProfilePostsResponseCopyWithImpl<$Res>;
  $Res call({List<ProfilePosts> profile_posts, Pagination? pagination});

  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$ProfilePostsResponseCopyWithImpl<$Res>
    implements $ProfilePostsResponseCopyWith<$Res> {
  _$ProfilePostsResponseCopyWithImpl(this._value, this._then);

  final ProfilePostsResponse _value;
  // ignore: unused_field
  final $Res Function(ProfilePostsResponse) _then;

  @override
  $Res call({
    Object? profile_posts = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      profile_posts: profile_posts == freezed
          ? _value.profile_posts
          : profile_posts // ignore: cast_nullable_to_non_nullable
              as List<ProfilePosts>,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
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
abstract class _$$_ProfilePostsResponseCopyWith<$Res>
    implements $ProfilePostsResponseCopyWith<$Res> {
  factory _$$_ProfilePostsResponseCopyWith(_$_ProfilePostsResponse value,
          $Res Function(_$_ProfilePostsResponse) then) =
      __$$_ProfilePostsResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<ProfilePosts> profile_posts, Pagination? pagination});

  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$_ProfilePostsResponseCopyWithImpl<$Res>
    extends _$ProfilePostsResponseCopyWithImpl<$Res>
    implements _$$_ProfilePostsResponseCopyWith<$Res> {
  __$$_ProfilePostsResponseCopyWithImpl(_$_ProfilePostsResponse _value,
      $Res Function(_$_ProfilePostsResponse) _then)
      : super(_value, (v) => _then(v as _$_ProfilePostsResponse));

  @override
  _$_ProfilePostsResponse get _value => super._value as _$_ProfilePostsResponse;

  @override
  $Res call({
    Object? profile_posts = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$_ProfilePostsResponse(
      profile_posts: profile_posts == freezed
          ? _value._profile_posts
          : profile_posts // ignore: cast_nullable_to_non_nullable
              as List<ProfilePosts>,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProfilePostsResponse implements _ProfilePostsResponse {
  const _$_ProfilePostsResponse(
      {required final List<ProfilePosts> profile_posts, this.pagination})
      : _profile_posts = profile_posts;

  factory _$_ProfilePostsResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ProfilePostsResponseFromJson(json);

  final List<ProfilePosts> _profile_posts;
  @override
  List<ProfilePosts> get profile_posts {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profile_posts);
  }

  @override
  final Pagination? pagination;

  @override
  String toString() {
    return 'ProfilePostsResponse(profile_posts: $profile_posts, pagination: $pagination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfilePostsResponse &&
            const DeepCollectionEquality()
                .equals(other._profile_posts, _profile_posts) &&
            const DeepCollectionEquality()
                .equals(other.pagination, pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_profile_posts),
      const DeepCollectionEquality().hash(pagination));

  @JsonKey(ignore: true)
  @override
  _$$_ProfilePostsResponseCopyWith<_$_ProfilePostsResponse> get copyWith =>
      __$$_ProfilePostsResponseCopyWithImpl<_$_ProfilePostsResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfilePostsResponseToJson(this);
  }
}

abstract class _ProfilePostsResponse implements ProfilePostsResponse {
  const factory _ProfilePostsResponse(
      {required final List<ProfilePosts> profile_posts,
      final Pagination? pagination}) = _$_ProfilePostsResponse;

  factory _ProfilePostsResponse.fromJson(Map<String, dynamic> json) =
      _$_ProfilePostsResponse.fromJson;

  @override
  List<ProfilePosts> get profile_posts;
  @override
  Pagination? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$_ProfilePostsResponseCopyWith<_$_ProfilePostsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
