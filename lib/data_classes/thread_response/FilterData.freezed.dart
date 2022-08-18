// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'FilterData.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FilterData _$FilterDataFromJson(Map<String, dynamic> json) {
  return _ThreadResponse.fromJson(json);
}

/// @nodoc
mixin _$FilterData {
  UserData? get exact => throw _privateConstructorUsedError;
  List<UserData>? get recommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterDataCopyWith<FilterData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterDataCopyWith<$Res> {
  factory $FilterDataCopyWith(
          FilterData value, $Res Function(FilterData) then) =
      _$FilterDataCopyWithImpl<$Res>;
  $Res call({UserData? exact, List<UserData>? recommendations});

  $UserDataCopyWith<$Res>? get exact;
}

/// @nodoc
class _$FilterDataCopyWithImpl<$Res> implements $FilterDataCopyWith<$Res> {
  _$FilterDataCopyWithImpl(this._value, this._then);

  final FilterData _value;
  // ignore: unused_field
  final $Res Function(FilterData) _then;

  @override
  $Res call({
    Object? exact = freezed,
    Object? recommendations = freezed,
  }) {
    return _then(_value.copyWith(
      exact: exact == freezed
          ? _value.exact
          : exact // ignore: cast_nullable_to_non_nullable
              as UserData?,
      recommendations: recommendations == freezed
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<UserData>?,
    ));
  }

  @override
  $UserDataCopyWith<$Res>? get exact {
    if (_value.exact == null) {
      return null;
    }

    return $UserDataCopyWith<$Res>(_value.exact!, (value) {
      return _then(_value.copyWith(exact: value));
    });
  }
}

/// @nodoc
abstract class _$$_ThreadResponseCopyWith<$Res>
    implements $FilterDataCopyWith<$Res> {
  factory _$$_ThreadResponseCopyWith(
          _$_ThreadResponse value, $Res Function(_$_ThreadResponse) then) =
      __$$_ThreadResponseCopyWithImpl<$Res>;
  @override
  $Res call({UserData? exact, List<UserData>? recommendations});

  @override
  $UserDataCopyWith<$Res>? get exact;
}

/// @nodoc
class __$$_ThreadResponseCopyWithImpl<$Res>
    extends _$FilterDataCopyWithImpl<$Res>
    implements _$$_ThreadResponseCopyWith<$Res> {
  __$$_ThreadResponseCopyWithImpl(
      _$_ThreadResponse _value, $Res Function(_$_ThreadResponse) _then)
      : super(_value, (v) => _then(v as _$_ThreadResponse));

  @override
  _$_ThreadResponse get _value => super._value as _$_ThreadResponse;

  @override
  $Res call({
    Object? exact = freezed,
    Object? recommendations = freezed,
  }) {
    return _then(_$_ThreadResponse(
      exact: exact == freezed
          ? _value.exact
          : exact // ignore: cast_nullable_to_non_nullable
              as UserData?,
      recommendations: recommendations == freezed
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<UserData>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ThreadResponse implements _ThreadResponse {
  const _$_ThreadResponse({this.exact, final List<UserData>? recommendations})
      : _recommendations = recommendations;

  factory _$_ThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ThreadResponseFromJson(json);

  @override
  final UserData? exact;
  final List<UserData>? _recommendations;
  @override
  List<UserData>? get recommendations {
    final value = _recommendations;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FilterData(exact: $exact, recommendations: $recommendations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThreadResponse &&
            const DeepCollectionEquality().equals(other.exact, exact) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(exact),
      const DeepCollectionEquality().hash(_recommendations));

  @JsonKey(ignore: true)
  @override
  _$$_ThreadResponseCopyWith<_$_ThreadResponse> get copyWith =>
      __$$_ThreadResponseCopyWithImpl<_$_ThreadResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ThreadResponseToJson(this);
  }
}

abstract class _ThreadResponse implements FilterData {
  const factory _ThreadResponse(
      {final UserData? exact,
      final List<UserData>? recommendations}) = _$_ThreadResponse;

  factory _ThreadResponse.fromJson(Map<String, dynamic> json) =
      _$_ThreadResponse.fromJson;

  @override
  UserData? get exact;
  @override
  List<UserData>? get recommendations;
  @override
  @JsonKey(ignore: true)
  _$$_ThreadResponseCopyWith<_$_ThreadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
