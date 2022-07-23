// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'Pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return _Pagination.fromJson(json);
}

/// @nodoc
mixin _$Pagination {
  int get current_page => throw _privateConstructorUsedError;
  int get last_page => throw _privateConstructorUsedError;
  int get per_page => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationCopyWith<Pagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationCopyWith<$Res> {
  factory $PaginationCopyWith(
          Pagination value, $Res Function(Pagination) then) =
      _$PaginationCopyWithImpl<$Res>;
  $Res call({int current_page, int last_page, int per_page, int total});
}

/// @nodoc
class _$PaginationCopyWithImpl<$Res> implements $PaginationCopyWith<$Res> {
  _$PaginationCopyWithImpl(this._value, this._then);

  final Pagination _value;
  // ignore: unused_field
  final $Res Function(Pagination) _then;

  @override
  $Res call({
    Object? current_page = freezed,
    Object? last_page = freezed,
    Object? per_page = freezed,
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      current_page: current_page == freezed
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int,
      last_page: last_page == freezed
          ? _value.last_page
          : last_page // ignore: cast_nullable_to_non_nullable
              as int,
      per_page: per_page == freezed
          ? _value.per_page
          : per_page // ignore: cast_nullable_to_non_nullable
              as int,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_PaginationCopyWith<$Res>
    implements $PaginationCopyWith<$Res> {
  factory _$$_PaginationCopyWith(
          _$_Pagination value, $Res Function(_$_Pagination) then) =
      __$$_PaginationCopyWithImpl<$Res>;
  @override
  $Res call({int current_page, int last_page, int per_page, int total});
}

/// @nodoc
class __$$_PaginationCopyWithImpl<$Res> extends _$PaginationCopyWithImpl<$Res>
    implements _$$_PaginationCopyWith<$Res> {
  __$$_PaginationCopyWithImpl(
      _$_Pagination _value, $Res Function(_$_Pagination) _then)
      : super(_value, (v) => _then(v as _$_Pagination));

  @override
  _$_Pagination get _value => super._value as _$_Pagination;

  @override
  $Res call({
    Object? current_page = freezed,
    Object? last_page = freezed,
    Object? per_page = freezed,
    Object? total = freezed,
  }) {
    return _then(_$_Pagination(
      current_page: current_page == freezed
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int,
      last_page: last_page == freezed
          ? _value.last_page
          : last_page // ignore: cast_nullable_to_non_nullable
              as int,
      per_page: per_page == freezed
          ? _value.per_page
          : per_page // ignore: cast_nullable_to_non_nullable
              as int,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Pagination implements _Pagination {
  const _$_Pagination(
      {this.current_page = 0,
      this.last_page = 0,
      this.per_page = 0,
      this.total = 0});

  factory _$_Pagination.fromJson(Map<String, dynamic> json) =>
      _$$_PaginationFromJson(json);

  @override
  @JsonKey()
  final int current_page;
  @override
  @JsonKey()
  final int last_page;
  @override
  @JsonKey()
  final int per_page;
  @override
  @JsonKey()
  final int total;

  @override
  String toString() {
    return 'Pagination(current_page: $current_page, last_page: $last_page, per_page: $per_page, total: $total)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Pagination &&
            const DeepCollectionEquality()
                .equals(other.current_page, current_page) &&
            const DeepCollectionEquality().equals(other.last_page, last_page) &&
            const DeepCollectionEquality().equals(other.per_page, per_page) &&
            const DeepCollectionEquality().equals(other.total, total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(current_page),
      const DeepCollectionEquality().hash(last_page),
      const DeepCollectionEquality().hash(per_page),
      const DeepCollectionEquality().hash(total));

  @JsonKey(ignore: true)
  @override
  _$$_PaginationCopyWith<_$_Pagination> get copyWith =>
      __$$_PaginationCopyWithImpl<_$_Pagination>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaginationToJson(this);
  }
}

abstract class _Pagination implements Pagination {
  const factory _Pagination(
      {final int current_page,
      final int last_page,
      final int per_page,
      final int total}) = _$_Pagination;

  factory _Pagination.fromJson(Map<String, dynamic> json) =
      _$_Pagination.fromJson;

  @override
  int get current_page;
  @override
  int get last_page;
  @override
  int get per_page;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_PaginationCopyWith<_$_Pagination> get copyWith =>
      throw _privateConstructorUsedError;
}
