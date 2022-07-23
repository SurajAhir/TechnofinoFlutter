// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ForumData.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ForumData _$ForumDataFromJson(Map<String, dynamic> json) {
  return _ForumData.fromJson(json);
}

/// @nodoc
mixin _$ForumData {
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForumDataCopyWith<ForumData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumDataCopyWith<$Res> {
  factory $ForumDataCopyWith(ForumData value, $Res Function(ForumData) then) =
      _$ForumDataCopyWithImpl<$Res>;
  $Res call({String title});
}

/// @nodoc
class _$ForumDataCopyWithImpl<$Res> implements $ForumDataCopyWith<$Res> {
  _$ForumDataCopyWithImpl(this._value, this._then);

  final ForumData _value;
  // ignore: unused_field
  final $Res Function(ForumData) _then;

  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ForumDataCopyWith<$Res> implements $ForumDataCopyWith<$Res> {
  factory _$$_ForumDataCopyWith(
          _$_ForumData value, $Res Function(_$_ForumData) then) =
      __$$_ForumDataCopyWithImpl<$Res>;
  @override
  $Res call({String title});
}

/// @nodoc
class __$$_ForumDataCopyWithImpl<$Res> extends _$ForumDataCopyWithImpl<$Res>
    implements _$$_ForumDataCopyWith<$Res> {
  __$$_ForumDataCopyWithImpl(
      _$_ForumData _value, $Res Function(_$_ForumData) _then)
      : super(_value, (v) => _then(v as _$_ForumData));

  @override
  _$_ForumData get _value => super._value as _$_ForumData;

  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_$_ForumData(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ForumData implements _ForumData {
  const _$_ForumData({this.title = ""});

  factory _$_ForumData.fromJson(Map<String, dynamic> json) =>
      _$$_ForumDataFromJson(json);

  @override
  @JsonKey()
  final String title;

  @override
  String toString() {
    return 'ForumData(title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForumData &&
            const DeepCollectionEquality().equals(other.title, title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(title));

  @JsonKey(ignore: true)
  @override
  _$$_ForumDataCopyWith<_$_ForumData> get copyWith =>
      __$$_ForumDataCopyWithImpl<_$_ForumData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ForumDataToJson(this);
  }
}

abstract class _ForumData implements ForumData {
  const factory _ForumData({final String title}) = _$_ForumData;

  factory _ForumData.fromJson(Map<String, dynamic> json) =
      _$_ForumData.fromJson;

  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$_ForumDataCopyWith<_$_ForumData> get copyWith =>
      throw _privateConstructorUsedError;
}
