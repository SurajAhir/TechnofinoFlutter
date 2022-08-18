// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'TypeData.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TypeData _$TypeDataFromJson(Map<String, dynamic> json) {
  return _TypeData.fromJson(json);
}

/// @nodoc
mixin _$TypeData {
  double get last_post_date => throw _privateConstructorUsedError;
  String get last_post_username => throw _privateConstructorUsedError;
  int get last_thread_id => throw _privateConstructorUsedError;
  String get last_thread_title => throw _privateConstructorUsedError;
  int get message_count => throw _privateConstructorUsedError;
  int get discussion_count => throw _privateConstructorUsedError;
  bool get allow_posting => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TypeDataCopyWith<TypeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeDataCopyWith<$Res> {
  factory $TypeDataCopyWith(TypeData value, $Res Function(TypeData) then) =
      _$TypeDataCopyWithImpl<$Res>;
  $Res call(
      {double last_post_date,
      String last_post_username,
      int last_thread_id,
      String last_thread_title,
      int message_count,
      int discussion_count,
      bool allow_posting});
}

/// @nodoc
class _$TypeDataCopyWithImpl<$Res> implements $TypeDataCopyWith<$Res> {
  _$TypeDataCopyWithImpl(this._value, this._then);

  final TypeData _value;
  // ignore: unused_field
  final $Res Function(TypeData) _then;

  @override
  $Res call({
    Object? last_post_date = freezed,
    Object? last_post_username = freezed,
    Object? last_thread_id = freezed,
    Object? last_thread_title = freezed,
    Object? message_count = freezed,
    Object? discussion_count = freezed,
    Object? allow_posting = freezed,
  }) {
    return _then(_value.copyWith(
      last_post_date: last_post_date == freezed
          ? _value.last_post_date
          : last_post_date // ignore: cast_nullable_to_non_nullable
              as double,
      last_post_username: last_post_username == freezed
          ? _value.last_post_username
          : last_post_username // ignore: cast_nullable_to_non_nullable
              as String,
      last_thread_id: last_thread_id == freezed
          ? _value.last_thread_id
          : last_thread_id // ignore: cast_nullable_to_non_nullable
              as int,
      last_thread_title: last_thread_title == freezed
          ? _value.last_thread_title
          : last_thread_title // ignore: cast_nullable_to_non_nullable
              as String,
      message_count: message_count == freezed
          ? _value.message_count
          : message_count // ignore: cast_nullable_to_non_nullable
              as int,
      discussion_count: discussion_count == freezed
          ? _value.discussion_count
          : discussion_count // ignore: cast_nullable_to_non_nullable
              as int,
      allow_posting: allow_posting == freezed
          ? _value.allow_posting
          : allow_posting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_TypeDataCopyWith<$Res> implements $TypeDataCopyWith<$Res> {
  factory _$$_TypeDataCopyWith(
          _$_TypeData value, $Res Function(_$_TypeData) then) =
      __$$_TypeDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {double last_post_date,
      String last_post_username,
      int last_thread_id,
      String last_thread_title,
      int message_count,
      int discussion_count,
      bool allow_posting});
}

/// @nodoc
class __$$_TypeDataCopyWithImpl<$Res> extends _$TypeDataCopyWithImpl<$Res>
    implements _$$_TypeDataCopyWith<$Res> {
  __$$_TypeDataCopyWithImpl(
      _$_TypeData _value, $Res Function(_$_TypeData) _then)
      : super(_value, (v) => _then(v as _$_TypeData));

  @override
  _$_TypeData get _value => super._value as _$_TypeData;

  @override
  $Res call({
    Object? last_post_date = freezed,
    Object? last_post_username = freezed,
    Object? last_thread_id = freezed,
    Object? last_thread_title = freezed,
    Object? message_count = freezed,
    Object? discussion_count = freezed,
    Object? allow_posting = freezed,
  }) {
    return _then(_$_TypeData(
      last_post_date: last_post_date == freezed
          ? _value.last_post_date
          : last_post_date // ignore: cast_nullable_to_non_nullable
              as double,
      last_post_username: last_post_username == freezed
          ? _value.last_post_username
          : last_post_username // ignore: cast_nullable_to_non_nullable
              as String,
      last_thread_id: last_thread_id == freezed
          ? _value.last_thread_id
          : last_thread_id // ignore: cast_nullable_to_non_nullable
              as int,
      last_thread_title: last_thread_title == freezed
          ? _value.last_thread_title
          : last_thread_title // ignore: cast_nullable_to_non_nullable
              as String,
      message_count: message_count == freezed
          ? _value.message_count
          : message_count // ignore: cast_nullable_to_non_nullable
              as int,
      discussion_count: discussion_count == freezed
          ? _value.discussion_count
          : discussion_count // ignore: cast_nullable_to_non_nullable
              as int,
      allow_posting: allow_posting == freezed
          ? _value.allow_posting
          : allow_posting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TypeData implements _TypeData {
  const _$_TypeData(
      {this.last_post_date = 0,
      this.last_post_username = "",
      this.last_thread_id = 0,
      this.last_thread_title = "",
      this.message_count = 0,
      this.discussion_count = 0,
      this.allow_posting = false});

  factory _$_TypeData.fromJson(Map<String, dynamic> json) =>
      _$$_TypeDataFromJson(json);

  @override
  @JsonKey()
  final double last_post_date;
  @override
  @JsonKey()
  final String last_post_username;
  @override
  @JsonKey()
  final int last_thread_id;
  @override
  @JsonKey()
  final String last_thread_title;
  @override
  @JsonKey()
  final int message_count;
  @override
  @JsonKey()
  final int discussion_count;
  @override
  @JsonKey()
  final bool allow_posting;

  @override
  String toString() {
    return 'TypeData(last_post_date: $last_post_date, last_post_username: $last_post_username, last_thread_id: $last_thread_id, last_thread_title: $last_thread_title, message_count: $message_count, discussion_count: $discussion_count, allow_posting: $allow_posting)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeData &&
            const DeepCollectionEquality()
                .equals(other.last_post_date, last_post_date) &&
            const DeepCollectionEquality()
                .equals(other.last_post_username, last_post_username) &&
            const DeepCollectionEquality()
                .equals(other.last_thread_id, last_thread_id) &&
            const DeepCollectionEquality()
                .equals(other.last_thread_title, last_thread_title) &&
            const DeepCollectionEquality()
                .equals(other.message_count, message_count) &&
            const DeepCollectionEquality()
                .equals(other.discussion_count, discussion_count) &&
            const DeepCollectionEquality()
                .equals(other.allow_posting, allow_posting));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(last_post_date),
      const DeepCollectionEquality().hash(last_post_username),
      const DeepCollectionEquality().hash(last_thread_id),
      const DeepCollectionEquality().hash(last_thread_title),
      const DeepCollectionEquality().hash(message_count),
      const DeepCollectionEquality().hash(discussion_count),
      const DeepCollectionEquality().hash(allow_posting));

  @JsonKey(ignore: true)
  @override
  _$$_TypeDataCopyWith<_$_TypeData> get copyWith =>
      __$$_TypeDataCopyWithImpl<_$_TypeData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TypeDataToJson(this);
  }
}

abstract class _TypeData implements TypeData {
  const factory _TypeData(
      {final double last_post_date,
      final String last_post_username,
      final int last_thread_id,
      final String last_thread_title,
      final int message_count,
      final int discussion_count,
      final bool allow_posting}) = _$_TypeData;

  factory _TypeData.fromJson(Map<String, dynamic> json) = _$_TypeData.fromJson;

  @override
  double get last_post_date;
  @override
  String get last_post_username;
  @override
  int get last_thread_id;
  @override
  String get last_thread_title;
  @override
  int get message_count;
  @override
  int get discussion_count;
  @override
  bool get allow_posting;
  @override
  @JsonKey(ignore: true)
  _$$_TypeDataCopyWith<_$_TypeData> get copyWith =>
      throw _privateConstructorUsedError;
}
