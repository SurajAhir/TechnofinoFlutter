// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ForumResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ForumResponse _$ForumResponseFromJson(Map<String, dynamic> json) {
  return _ForumResponse.fromJson(json);
}

/// @nodoc
mixin _$ForumResponse {
  List<ForumData>? get breadcrumbs => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForumResponseCopyWith<ForumResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumResponseCopyWith<$Res> {
  factory $ForumResponseCopyWith(
          ForumResponse value, $Res Function(ForumResponse) then) =
      _$ForumResponseCopyWithImpl<$Res>;
  $Res call({List<ForumData>? breadcrumbs, String title, String description});
}

/// @nodoc
class _$ForumResponseCopyWithImpl<$Res>
    implements $ForumResponseCopyWith<$Res> {
  _$ForumResponseCopyWithImpl(this._value, this._then);

  final ForumResponse _value;
  // ignore: unused_field
  final $Res Function(ForumResponse) _then;

  @override
  $Res call({
    Object? breadcrumbs = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      breadcrumbs: breadcrumbs == freezed
          ? _value.breadcrumbs
          : breadcrumbs // ignore: cast_nullable_to_non_nullable
              as List<ForumData>?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ForumResponseCopyWith<$Res>
    implements $ForumResponseCopyWith<$Res> {
  factory _$$_ForumResponseCopyWith(
          _$_ForumResponse value, $Res Function(_$_ForumResponse) then) =
      __$$_ForumResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<ForumData>? breadcrumbs, String title, String description});
}

/// @nodoc
class __$$_ForumResponseCopyWithImpl<$Res>
    extends _$ForumResponseCopyWithImpl<$Res>
    implements _$$_ForumResponseCopyWith<$Res> {
  __$$_ForumResponseCopyWithImpl(
      _$_ForumResponse _value, $Res Function(_$_ForumResponse) _then)
      : super(_value, (v) => _then(v as _$_ForumResponse));

  @override
  _$_ForumResponse get _value => super._value as _$_ForumResponse;

  @override
  $Res call({
    Object? breadcrumbs = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_ForumResponse(
      breadcrumbs: breadcrumbs == freezed
          ? _value._breadcrumbs
          : breadcrumbs // ignore: cast_nullable_to_non_nullable
              as List<ForumData>?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ForumResponse implements _ForumResponse {
  const _$_ForumResponse(
      {final List<ForumData>? breadcrumbs,
      this.title = "",
      this.description = ""})
      : _breadcrumbs = breadcrumbs;

  factory _$_ForumResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ForumResponseFromJson(json);

  final List<ForumData>? _breadcrumbs;
  @override
  List<ForumData>? get breadcrumbs {
    final value = _breadcrumbs;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'ForumResponse(breadcrumbs: $breadcrumbs, title: $title, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForumResponse &&
            const DeepCollectionEquality()
                .equals(other._breadcrumbs, _breadcrumbs) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_breadcrumbs),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$$_ForumResponseCopyWith<_$_ForumResponse> get copyWith =>
      __$$_ForumResponseCopyWithImpl<_$_ForumResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ForumResponseToJson(this);
  }
}

abstract class _ForumResponse implements ForumResponse {
  const factory _ForumResponse(
      {final List<ForumData>? breadcrumbs,
      final String title,
      final String description}) = _$_ForumResponse;

  factory _ForumResponse.fromJson(Map<String, dynamic> json) =
      _$_ForumResponse.fromJson;

  @override
  List<ForumData>? get breadcrumbs;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$_ForumResponseCopyWith<_$_ForumResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
