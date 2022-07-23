// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'NotificationResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationResponse _$NotificationResponseFromJson(Map<String, dynamic> json) {
  return _NotificationResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationResponse {
  List<NotificationsData> get alerts => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationResponseCopyWith<NotificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationResponseCopyWith<$Res> {
  factory $NotificationResponseCopyWith(NotificationResponse value,
          $Res Function(NotificationResponse) then) =
      _$NotificationResponseCopyWithImpl<$Res>;
  $Res call({List<NotificationsData> alerts, Pagination? pagination});

  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$NotificationResponseCopyWithImpl<$Res>
    implements $NotificationResponseCopyWith<$Res> {
  _$NotificationResponseCopyWithImpl(this._value, this._then);

  final NotificationResponse _value;
  // ignore: unused_field
  final $Res Function(NotificationResponse) _then;

  @override
  $Res call({
    Object? alerts = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      alerts: alerts == freezed
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<NotificationsData>,
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
abstract class _$$_NotificationResponseCopyWith<$Res>
    implements $NotificationResponseCopyWith<$Res> {
  factory _$$_NotificationResponseCopyWith(_$_NotificationResponse value,
          $Res Function(_$_NotificationResponse) then) =
      __$$_NotificationResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<NotificationsData> alerts, Pagination? pagination});

  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$_NotificationResponseCopyWithImpl<$Res>
    extends _$NotificationResponseCopyWithImpl<$Res>
    implements _$$_NotificationResponseCopyWith<$Res> {
  __$$_NotificationResponseCopyWithImpl(_$_NotificationResponse _value,
      $Res Function(_$_NotificationResponse) _then)
      : super(_value, (v) => _then(v as _$_NotificationResponse));

  @override
  _$_NotificationResponse get _value => super._value as _$_NotificationResponse;

  @override
  $Res call({
    Object? alerts = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$_NotificationResponse(
      alerts: alerts == freezed
          ? _value._alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<NotificationsData>,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationResponse implements _NotificationResponse {
  const _$_NotificationResponse(
      {required final List<NotificationsData> alerts, this.pagination})
      : _alerts = alerts;

  factory _$_NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationResponseFromJson(json);

  final List<NotificationsData> _alerts;
  @override
  List<NotificationsData> get alerts {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  @override
  final Pagination? pagination;

  @override
  String toString() {
    return 'NotificationResponse(alerts: $alerts, pagination: $pagination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationResponse &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            const DeepCollectionEquality()
                .equals(other.pagination, pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_alerts),
      const DeepCollectionEquality().hash(pagination));

  @JsonKey(ignore: true)
  @override
  _$$_NotificationResponseCopyWith<_$_NotificationResponse> get copyWith =>
      __$$_NotificationResponseCopyWithImpl<_$_NotificationResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationResponseToJson(this);
  }
}

abstract class _NotificationResponse implements NotificationResponse {
  const factory _NotificationResponse(
      {required final List<NotificationsData> alerts,
      final Pagination? pagination}) = _$_NotificationResponse;

  factory _NotificationResponse.fromJson(Map<String, dynamic> json) =
      _$_NotificationResponse.fromJson;

  @override
  List<NotificationsData> get alerts;
  @override
  Pagination? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationResponseCopyWith<_$_NotificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
