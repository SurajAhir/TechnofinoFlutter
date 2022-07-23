// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'TapiReaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TapiReaction _$TapiReactionFromJson(Map<String, dynamic> json) {
  return _TapiReaction.fromJson(json);
}

/// @nodoc
mixin _$TapiReaction {
  String get image => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TapiReactionCopyWith<TapiReaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TapiReactionCopyWith<$Res> {
  factory $TapiReactionCopyWith(
          TapiReaction value, $Res Function(TapiReaction) then) =
      _$TapiReactionCopyWithImpl<$Res>;
  $Res call({String image, int total});
}

/// @nodoc
class _$TapiReactionCopyWithImpl<$Res> implements $TapiReactionCopyWith<$Res> {
  _$TapiReactionCopyWithImpl(this._value, this._then);

  final TapiReaction _value;
  // ignore: unused_field
  final $Res Function(TapiReaction) _then;

  @override
  $Res call({
    Object? image = freezed,
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_TapiReactionCopyWith<$Res>
    implements $TapiReactionCopyWith<$Res> {
  factory _$$_TapiReactionCopyWith(
          _$_TapiReaction value, $Res Function(_$_TapiReaction) then) =
      __$$_TapiReactionCopyWithImpl<$Res>;
  @override
  $Res call({String image, int total});
}

/// @nodoc
class __$$_TapiReactionCopyWithImpl<$Res>
    extends _$TapiReactionCopyWithImpl<$Res>
    implements _$$_TapiReactionCopyWith<$Res> {
  __$$_TapiReactionCopyWithImpl(
      _$_TapiReaction _value, $Res Function(_$_TapiReaction) _then)
      : super(_value, (v) => _then(v as _$_TapiReaction));

  @override
  _$_TapiReaction get _value => super._value as _$_TapiReaction;

  @override
  $Res call({
    Object? image = freezed,
    Object? total = freezed,
  }) {
    return _then(_$_TapiReaction(
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TapiReaction implements _TapiReaction {
  const _$_TapiReaction({this.image = "", this.total = 0});

  factory _$_TapiReaction.fromJson(Map<String, dynamic> json) =>
      _$$_TapiReactionFromJson(json);

  @override
  @JsonKey()
  final String image;
  @override
  @JsonKey()
  final int total;

  @override
  String toString() {
    return 'TapiReaction(image: $image, total: $total)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TapiReaction &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.total, total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(total));

  @JsonKey(ignore: true)
  @override
  _$$_TapiReactionCopyWith<_$_TapiReaction> get copyWith =>
      __$$_TapiReactionCopyWithImpl<_$_TapiReaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TapiReactionToJson(this);
  }
}

abstract class _TapiReaction implements TapiReaction {
  const factory _TapiReaction({final String image, final int total}) =
      _$_TapiReaction;

  factory _TapiReaction.fromJson(Map<String, dynamic> json) =
      _$_TapiReaction.fromJson;

  @override
  String get image;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_TapiReactionCopyWith<_$_TapiReaction> get copyWith =>
      throw _privateConstructorUsedError;
}
