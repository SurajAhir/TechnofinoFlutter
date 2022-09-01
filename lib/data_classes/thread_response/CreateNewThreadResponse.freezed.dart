// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'CreateNewThreadResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreateNewThreadResponse _$CreateNewThreadResponseFromJson(
    Map<String, dynamic> json) {
  return _CreateNewThreadResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateNewThreadResponse {
  Threads get thread => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateNewThreadResponseCopyWith<CreateNewThreadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateNewThreadResponseCopyWith<$Res> {
  factory $CreateNewThreadResponseCopyWith(CreateNewThreadResponse value,
          $Res Function(CreateNewThreadResponse) then) =
      _$CreateNewThreadResponseCopyWithImpl<$Res>;
  $Res call({Threads thread, bool success});

  $ThreadsCopyWith<$Res> get thread;
}

/// @nodoc
class _$CreateNewThreadResponseCopyWithImpl<$Res>
    implements $CreateNewThreadResponseCopyWith<$Res> {
  _$CreateNewThreadResponseCopyWithImpl(this._value, this._then);

  final CreateNewThreadResponse _value;
  // ignore: unused_field
  final $Res Function(CreateNewThreadResponse) _then;

  @override
  $Res call({
    Object? thread = freezed,
    Object? success = freezed,
  }) {
    return _then(_value.copyWith(
      thread: thread == freezed
          ? _value.thread
          : thread // ignore: cast_nullable_to_non_nullable
              as Threads,
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $ThreadsCopyWith<$Res> get thread {
    return $ThreadsCopyWith<$Res>(_value.thread, (value) {
      return _then(_value.copyWith(thread: value));
    });
  }
}

/// @nodoc
abstract class _$$_CreateNewThreadResponseCopyWith<$Res>
    implements $CreateNewThreadResponseCopyWith<$Res> {
  factory _$$_CreateNewThreadResponseCopyWith(_$_CreateNewThreadResponse value,
          $Res Function(_$_CreateNewThreadResponse) then) =
      __$$_CreateNewThreadResponseCopyWithImpl<$Res>;
  @override
  $Res call({Threads thread, bool success});

  @override
  $ThreadsCopyWith<$Res> get thread;
}

/// @nodoc
class __$$_CreateNewThreadResponseCopyWithImpl<$Res>
    extends _$CreateNewThreadResponseCopyWithImpl<$Res>
    implements _$$_CreateNewThreadResponseCopyWith<$Res> {
  __$$_CreateNewThreadResponseCopyWithImpl(_$_CreateNewThreadResponse _value,
      $Res Function(_$_CreateNewThreadResponse) _then)
      : super(_value, (v) => _then(v as _$_CreateNewThreadResponse));

  @override
  _$_CreateNewThreadResponse get _value =>
      super._value as _$_CreateNewThreadResponse;

  @override
  $Res call({
    Object? thread = freezed,
    Object? success = freezed,
  }) {
    return _then(_$_CreateNewThreadResponse(
      thread: thread == freezed
          ? _value.thread
          : thread // ignore: cast_nullable_to_non_nullable
              as Threads,
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreateNewThreadResponse implements _CreateNewThreadResponse {
  const _$_CreateNewThreadResponse(
      {required this.thread, this.success = false});

  factory _$_CreateNewThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CreateNewThreadResponseFromJson(json);

  @override
  final Threads thread;
  @override
  @JsonKey()
  final bool success;

  @override
  String toString() {
    return 'CreateNewThreadResponse(thread: $thread, success: $success)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateNewThreadResponse &&
            const DeepCollectionEquality().equals(other.thread, thread) &&
            const DeepCollectionEquality().equals(other.success, success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(thread),
      const DeepCollectionEquality().hash(success));

  @JsonKey(ignore: true)
  @override
  _$$_CreateNewThreadResponseCopyWith<_$_CreateNewThreadResponse>
      get copyWith =>
          __$$_CreateNewThreadResponseCopyWithImpl<_$_CreateNewThreadResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreateNewThreadResponseToJson(this);
  }
}

abstract class _CreateNewThreadResponse implements CreateNewThreadResponse {
  const factory _CreateNewThreadResponse(
      {required final Threads thread,
      final bool success}) = _$_CreateNewThreadResponse;

  factory _CreateNewThreadResponse.fromJson(Map<String, dynamic> json) =
      _$_CreateNewThreadResponse.fromJson;

  @override
  Threads get thread;
  @override
  bool get success;
  @override
  @JsonKey(ignore: true)
  _$$_CreateNewThreadResponseCopyWith<_$_CreateNewThreadResponse>
      get copyWith => throw _privateConstructorUsedError;
}
