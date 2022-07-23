// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ReactData.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReactData _$ReactDataFromJson(Map<String, dynamic> json) {
  return _ReactData.fromJson(json);
}

/// @nodoc
mixin _$ReactData {
  bool get success => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReactDataCopyWith<ReactData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactDataCopyWith<$Res> {
  factory $ReactDataCopyWith(ReactData value, $Res Function(ReactData) then) =
      _$ReactDataCopyWithImpl<$Res>;
  $Res call({bool success, String action});
}

/// @nodoc
class _$ReactDataCopyWithImpl<$Res> implements $ReactDataCopyWith<$Res> {
  _$ReactDataCopyWithImpl(this._value, this._then);

  final ReactData _value;
  // ignore: unused_field
  final $Res Function(ReactData) _then;

  @override
  $Res call({
    Object? success = freezed,
    Object? action = freezed,
  }) {
    return _then(_value.copyWith(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ReactDataCopyWith<$Res> implements $ReactDataCopyWith<$Res> {
  factory _$$_ReactDataCopyWith(
          _$_ReactData value, $Res Function(_$_ReactData) then) =
      __$$_ReactDataCopyWithImpl<$Res>;
  @override
  $Res call({bool success, String action});
}

/// @nodoc
class __$$_ReactDataCopyWithImpl<$Res> extends _$ReactDataCopyWithImpl<$Res>
    implements _$$_ReactDataCopyWith<$Res> {
  __$$_ReactDataCopyWithImpl(
      _$_ReactData _value, $Res Function(_$_ReactData) _then)
      : super(_value, (v) => _then(v as _$_ReactData));

  @override
  _$_ReactData get _value => super._value as _$_ReactData;

  @override
  $Res call({
    Object? success = freezed,
    Object? action = freezed,
  }) {
    return _then(_$_ReactData(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReactData implements _ReactData {
  const _$_ReactData({this.success = false, this.action = ""});

  factory _$_ReactData.fromJson(Map<String, dynamic> json) =>
      _$$_ReactDataFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final String action;

  @override
  String toString() {
    return 'ReactData(success: $success, action: $action)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReactData &&
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.action, action));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(action));

  @JsonKey(ignore: true)
  @override
  _$$_ReactDataCopyWith<_$_ReactData> get copyWith =>
      __$$_ReactDataCopyWithImpl<_$_ReactData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReactDataToJson(this);
  }
}

abstract class _ReactData implements ReactData {
  const factory _ReactData({final bool success, final String action}) =
      _$_ReactData;

  factory _ReactData.fromJson(Map<String, dynamic> json) =
      _$_ReactData.fromJson;

  @override
  bool get success;
  @override
  String get action;
  @override
  @JsonKey(ignore: true)
  _$$_ReactDataCopyWith<_$_ReactData> get copyWith =>
      throw _privateConstructorUsedError;
}
