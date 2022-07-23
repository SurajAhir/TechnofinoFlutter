// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'PostFromNotification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostFromNotification _$PostFromNotificationFromJson(Map<String, dynamic> json) {
  return _PostFromNotification.fromJson(json);
}

/// @nodoc
mixin _$PostFromNotification {
  ThreadFromPost get post => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostFromNotificationCopyWith<PostFromNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostFromNotificationCopyWith<$Res> {
  factory $PostFromNotificationCopyWith(PostFromNotification value,
          $Res Function(PostFromNotification) then) =
      _$PostFromNotificationCopyWithImpl<$Res>;
  $Res call({ThreadFromPost post});

  $ThreadFromPostCopyWith<$Res> get post;
}

/// @nodoc
class _$PostFromNotificationCopyWithImpl<$Res>
    implements $PostFromNotificationCopyWith<$Res> {
  _$PostFromNotificationCopyWithImpl(this._value, this._then);

  final PostFromNotification _value;
  // ignore: unused_field
  final $Res Function(PostFromNotification) _then;

  @override
  $Res call({
    Object? post = freezed,
  }) {
    return _then(_value.copyWith(
      post: post == freezed
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as ThreadFromPost,
    ));
  }

  @override
  $ThreadFromPostCopyWith<$Res> get post {
    return $ThreadFromPostCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value));
    });
  }
}

/// @nodoc
abstract class _$$_PostFromNotificationCopyWith<$Res>
    implements $PostFromNotificationCopyWith<$Res> {
  factory _$$_PostFromNotificationCopyWith(_$_PostFromNotification value,
          $Res Function(_$_PostFromNotification) then) =
      __$$_PostFromNotificationCopyWithImpl<$Res>;
  @override
  $Res call({ThreadFromPost post});

  @override
  $ThreadFromPostCopyWith<$Res> get post;
}

/// @nodoc
class __$$_PostFromNotificationCopyWithImpl<$Res>
    extends _$PostFromNotificationCopyWithImpl<$Res>
    implements _$$_PostFromNotificationCopyWith<$Res> {
  __$$_PostFromNotificationCopyWithImpl(_$_PostFromNotification _value,
      $Res Function(_$_PostFromNotification) _then)
      : super(_value, (v) => _then(v as _$_PostFromNotification));

  @override
  _$_PostFromNotification get _value => super._value as _$_PostFromNotification;

  @override
  $Res call({
    Object? post = freezed,
  }) {
    return _then(_$_PostFromNotification(
      post: post == freezed
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as ThreadFromPost,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostFromNotification implements _PostFromNotification {
  const _$_PostFromNotification({required this.post});

  factory _$_PostFromNotification.fromJson(Map<String, dynamic> json) =>
      _$$_PostFromNotificationFromJson(json);

  @override
  final ThreadFromPost post;

  @override
  String toString() {
    return 'PostFromNotification(post: $post)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostFromNotification &&
            const DeepCollectionEquality().equals(other.post, post));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(post));

  @JsonKey(ignore: true)
  @override
  _$$_PostFromNotificationCopyWith<_$_PostFromNotification> get copyWith =>
      __$$_PostFromNotificationCopyWithImpl<_$_PostFromNotification>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostFromNotificationToJson(this);
  }
}

abstract class _PostFromNotification implements PostFromNotification {
  const factory _PostFromNotification({required final ThreadFromPost post}) =
      _$_PostFromNotification;

  factory _PostFromNotification.fromJson(Map<String, dynamic> json) =
      _$_PostFromNotification.fromJson;

  @override
  ThreadFromPost get post;
  @override
  @JsonKey(ignore: true)
  _$$_PostFromNotificationCopyWith<_$_PostFromNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
