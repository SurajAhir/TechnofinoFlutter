// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ThreadFromPost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ThreadFromPost _$ThreadFromPostFromJson(Map<String, dynamic> json) {
  return _ThreadFromPost.fromJson(json);
}

/// @nodoc
mixin _$ThreadFromPost {
  Threads get Thread => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThreadFromPostCopyWith<ThreadFromPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadFromPostCopyWith<$Res> {
  factory $ThreadFromPostCopyWith(
          ThreadFromPost value, $Res Function(ThreadFromPost) then) =
      _$ThreadFromPostCopyWithImpl<$Res>;
  $Res call({Threads Thread, int position});

  $ThreadsCopyWith<$Res> get Thread;
}

/// @nodoc
class _$ThreadFromPostCopyWithImpl<$Res>
    implements $ThreadFromPostCopyWith<$Res> {
  _$ThreadFromPostCopyWithImpl(this._value, this._then);

  final ThreadFromPost _value;
  // ignore: unused_field
  final $Res Function(ThreadFromPost) _then;

  @override
  $Res call({
    Object? Thread = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      Thread: Thread == freezed
          ? _value.Thread
          : Thread // ignore: cast_nullable_to_non_nullable
              as Threads,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $ThreadsCopyWith<$Res> get Thread {
    return $ThreadsCopyWith<$Res>(_value.Thread, (value) {
      return _then(_value.copyWith(Thread: value));
    });
  }
}

/// @nodoc
abstract class _$$_ThreadFromPostCopyWith<$Res>
    implements $ThreadFromPostCopyWith<$Res> {
  factory _$$_ThreadFromPostCopyWith(
          _$_ThreadFromPost value, $Res Function(_$_ThreadFromPost) then) =
      __$$_ThreadFromPostCopyWithImpl<$Res>;
  @override
  $Res call({Threads Thread, int position});

  @override
  $ThreadsCopyWith<$Res> get Thread;
}

/// @nodoc
class __$$_ThreadFromPostCopyWithImpl<$Res>
    extends _$ThreadFromPostCopyWithImpl<$Res>
    implements _$$_ThreadFromPostCopyWith<$Res> {
  __$$_ThreadFromPostCopyWithImpl(
      _$_ThreadFromPost _value, $Res Function(_$_ThreadFromPost) _then)
      : super(_value, (v) => _then(v as _$_ThreadFromPost));

  @override
  _$_ThreadFromPost get _value => super._value as _$_ThreadFromPost;

  @override
  $Res call({
    Object? Thread = freezed,
    Object? position = freezed,
  }) {
    return _then(_$_ThreadFromPost(
      Thread: Thread == freezed
          ? _value.Thread
          : Thread // ignore: cast_nullable_to_non_nullable
              as Threads,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ThreadFromPost implements _ThreadFromPost {
  const _$_ThreadFromPost({required this.Thread, this.position = 0});

  factory _$_ThreadFromPost.fromJson(Map<String, dynamic> json) =>
      _$$_ThreadFromPostFromJson(json);

  @override
  final Threads Thread;
  @override
  @JsonKey()
  final int position;

  @override
  String toString() {
    return 'ThreadFromPost(Thread: $Thread, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThreadFromPost &&
            const DeepCollectionEquality().equals(other.Thread, Thread) &&
            const DeepCollectionEquality().equals(other.position, position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(Thread),
      const DeepCollectionEquality().hash(position));

  @JsonKey(ignore: true)
  @override
  _$$_ThreadFromPostCopyWith<_$_ThreadFromPost> get copyWith =>
      __$$_ThreadFromPostCopyWithImpl<_$_ThreadFromPost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ThreadFromPostToJson(this);
  }
}

abstract class _ThreadFromPost implements ThreadFromPost {
  const factory _ThreadFromPost(
      {required final Threads Thread, final int position}) = _$_ThreadFromPost;

  factory _ThreadFromPost.fromJson(Map<String, dynamic> json) =
      _$_ThreadFromPost.fromJson;

  @override
  Threads get Thread;
  @override
  int get position;
  @override
  @JsonKey(ignore: true)
  _$$_ThreadFromPostCopyWith<_$_ThreadFromPost> get copyWith =>
      throw _privateConstructorUsedError;
}
