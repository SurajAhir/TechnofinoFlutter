// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ConversationResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConversationResponse _$ConversationResponseFromJson(Map<String, dynamic> json) {
  return _ConversationResponse.fromJson(json);
}

/// @nodoc
mixin _$ConversationResponse {
  List<Conversations> get conversations => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationResponseCopyWith<ConversationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationResponseCopyWith<$Res> {
  factory $ConversationResponseCopyWith(ConversationResponse value,
          $Res Function(ConversationResponse) then) =
      _$ConversationResponseCopyWithImpl<$Res>;
  $Res call({List<Conversations> conversations, Pagination? pagination});

  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$ConversationResponseCopyWithImpl<$Res>
    implements $ConversationResponseCopyWith<$Res> {
  _$ConversationResponseCopyWithImpl(this._value, this._then);

  final ConversationResponse _value;
  // ignore: unused_field
  final $Res Function(ConversationResponse) _then;

  @override
  $Res call({
    Object? conversations = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      conversations: conversations == freezed
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversations>,
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
abstract class _$$_ConversationResponseCopyWith<$Res>
    implements $ConversationResponseCopyWith<$Res> {
  factory _$$_ConversationResponseCopyWith(_$_ConversationResponse value,
          $Res Function(_$_ConversationResponse) then) =
      __$$_ConversationResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<Conversations> conversations, Pagination? pagination});

  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$_ConversationResponseCopyWithImpl<$Res>
    extends _$ConversationResponseCopyWithImpl<$Res>
    implements _$$_ConversationResponseCopyWith<$Res> {
  __$$_ConversationResponseCopyWithImpl(_$_ConversationResponse _value,
      $Res Function(_$_ConversationResponse) _then)
      : super(_value, (v) => _then(v as _$_ConversationResponse));

  @override
  _$_ConversationResponse get _value => super._value as _$_ConversationResponse;

  @override
  $Res call({
    Object? conversations = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$_ConversationResponse(
      conversations: conversations == freezed
          ? _value._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversations>,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationResponse implements _ConversationResponse {
  const _$_ConversationResponse(
      {required final List<Conversations> conversations, this.pagination})
      : _conversations = conversations;

  factory _$_ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationResponseFromJson(json);

  final List<Conversations> _conversations;
  @override
  List<Conversations> get conversations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  final Pagination? pagination;

  @override
  String toString() {
    return 'ConversationResponse(conversations: $conversations, pagination: $pagination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConversationResponse &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations) &&
            const DeepCollectionEquality()
                .equals(other.pagination, pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_conversations),
      const DeepCollectionEquality().hash(pagination));

  @JsonKey(ignore: true)
  @override
  _$$_ConversationResponseCopyWith<_$_ConversationResponse> get copyWith =>
      __$$_ConversationResponseCopyWithImpl<_$_ConversationResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationResponseToJson(this);
  }
}

abstract class _ConversationResponse implements ConversationResponse {
  const factory _ConversationResponse(
      {required final List<Conversations> conversations,
      final Pagination? pagination}) = _$_ConversationResponse;

  factory _ConversationResponse.fromJson(Map<String, dynamic> json) =
      _$_ConversationResponse.fromJson;

  @override
  List<Conversations> get conversations;
  @override
  Pagination? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationResponseCopyWith<_$_ConversationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
