// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ThreadResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ThreadResponse _$ThreadResponseFromJson(Map<String, dynamic> json) {
  return _ThreadResponse.fromJson(json);
}

/// @nodoc
mixin _$ThreadResponse {
  List<Threads> get threads => throw _privateConstructorUsedError;
  List<Threads>? get sticky => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThreadResponseCopyWith<ThreadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadResponseCopyWith<$Res> {
  factory $ThreadResponseCopyWith(
          ThreadResponse value, $Res Function(ThreadResponse) then) =
      _$ThreadResponseCopyWithImpl<$Res>;
  $Res call(
      {List<Threads> threads, List<Threads>? sticky, Pagination? pagination});

  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$ThreadResponseCopyWithImpl<$Res>
    implements $ThreadResponseCopyWith<$Res> {
  _$ThreadResponseCopyWithImpl(this._value, this._then);

  final ThreadResponse _value;
  // ignore: unused_field
  final $Res Function(ThreadResponse) _then;

  @override
  $Res call({
    Object? threads = freezed,
    Object? sticky = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      threads: threads == freezed
          ? _value.threads
          : threads // ignore: cast_nullable_to_non_nullable
              as List<Threads>,
      sticky: sticky == freezed
          ? _value.sticky
          : sticky // ignore: cast_nullable_to_non_nullable
              as List<Threads>?,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }

  @override
  $PaginationCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationCopyWith<$Res>(_value.pagination!, (value) {
      return _then(_value.copyWith(pagination: value));
    });
  }
}

/// @nodoc
abstract class _$$_ThreadResponseCopyWith<$Res>
    implements $ThreadResponseCopyWith<$Res> {
  factory _$$_ThreadResponseCopyWith(
          _$_ThreadResponse value, $Res Function(_$_ThreadResponse) then) =
      __$$_ThreadResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Threads> threads, List<Threads>? sticky, Pagination? pagination});

  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$_ThreadResponseCopyWithImpl<$Res>
    extends _$ThreadResponseCopyWithImpl<$Res>
    implements _$$_ThreadResponseCopyWith<$Res> {
  __$$_ThreadResponseCopyWithImpl(
      _$_ThreadResponse _value, $Res Function(_$_ThreadResponse) _then)
      : super(_value, (v) => _then(v as _$_ThreadResponse));

  @override
  _$_ThreadResponse get _value => super._value as _$_ThreadResponse;

  @override
  $Res call({
    Object? threads = freezed,
    Object? sticky = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$_ThreadResponse(
      threads: threads == freezed
          ? _value._threads
          : threads // ignore: cast_nullable_to_non_nullable
              as List<Threads>,
      sticky: sticky == freezed
          ? _value._sticky
          : sticky // ignore: cast_nullable_to_non_nullable
              as List<Threads>?,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ThreadResponse implements _ThreadResponse {
  const _$_ThreadResponse(
      {required final List<Threads> threads,
      final List<Threads>? sticky,
      this.pagination})
      : _threads = threads,
        _sticky = sticky;

  factory _$_ThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ThreadResponseFromJson(json);

  final List<Threads> _threads;
  @override
  List<Threads> get threads {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_threads);
  }

  final List<Threads>? _sticky;
  @override
  List<Threads>? get sticky {
    final value = _sticky;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Pagination? pagination;

  @override
  String toString() {
    return 'ThreadResponse(threads: $threads, sticky: $sticky, pagination: $pagination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThreadResponse &&
            const DeepCollectionEquality().equals(other._threads, _threads) &&
            const DeepCollectionEquality().equals(other._sticky, _sticky) &&
            const DeepCollectionEquality()
                .equals(other.pagination, pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_threads),
      const DeepCollectionEquality().hash(_sticky),
      const DeepCollectionEquality().hash(pagination));

  @JsonKey(ignore: true)
  @override
  _$$_ThreadResponseCopyWith<_$_ThreadResponse> get copyWith =>
      __$$_ThreadResponseCopyWithImpl<_$_ThreadResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ThreadResponseToJson(this);
  }
}

abstract class _ThreadResponse implements ThreadResponse {
  const factory _ThreadResponse(
      {required final List<Threads> threads,
      final List<Threads>? sticky,
      final Pagination? pagination}) = _$_ThreadResponse;

  factory _ThreadResponse.fromJson(Map<String, dynamic> json) =
      _$_ThreadResponse.fromJson;

  @override
  List<Threads> get threads;
  @override
  List<Threads>? get sticky;
  @override
  Pagination? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$_ThreadResponseCopyWith<_$_ThreadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
