// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ConversationMessages.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConversationMessages _$ConversationMessagesFromJson(Map<String, dynamic> json) {
  return _ConversationMessages.fromJson(json);
}

/// @nodoc
mixin _$ConversationMessages {
  List<PostsOfThreads> get messages => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationMessagesCopyWith<ConversationMessages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationMessagesCopyWith<$Res> {
  factory $ConversationMessagesCopyWith(ConversationMessages value,
          $Res Function(ConversationMessages) then) =
      _$ConversationMessagesCopyWithImpl<$Res>;
  $Res call({List<PostsOfThreads> messages, Pagination? pagination});

  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$ConversationMessagesCopyWithImpl<$Res>
    implements $ConversationMessagesCopyWith<$Res> {
  _$ConversationMessagesCopyWithImpl(this._value, this._then);

  final ConversationMessages _value;
  // ignore: unused_field
  final $Res Function(ConversationMessages) _then;

  @override
  $Res call({
    Object? messages = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<PostsOfThreads>,
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
abstract class _$$_ConversationMessagesCopyWith<$Res>
    implements $ConversationMessagesCopyWith<$Res> {
  factory _$$_ConversationMessagesCopyWith(_$_ConversationMessages value,
          $Res Function(_$_ConversationMessages) then) =
      __$$_ConversationMessagesCopyWithImpl<$Res>;
  @override
  $Res call({List<PostsOfThreads> messages, Pagination? pagination});

  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$_ConversationMessagesCopyWithImpl<$Res>
    extends _$ConversationMessagesCopyWithImpl<$Res>
    implements _$$_ConversationMessagesCopyWith<$Res> {
  __$$_ConversationMessagesCopyWithImpl(_$_ConversationMessages _value,
      $Res Function(_$_ConversationMessages) _then)
      : super(_value, (v) => _then(v as _$_ConversationMessages));

  @override
  _$_ConversationMessages get _value => super._value as _$_ConversationMessages;

  @override
  $Res call({
    Object? messages = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$_ConversationMessages(
      messages: messages == freezed
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<PostsOfThreads>,
      pagination: pagination == freezed
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationMessages implements _ConversationMessages {
  const _$_ConversationMessages(
      {required final List<PostsOfThreads> messages, this.pagination})
      : _messages = messages;

  factory _$_ConversationMessages.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationMessagesFromJson(json);

  final List<PostsOfThreads> _messages;
  @override
  List<PostsOfThreads> get messages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final Pagination? pagination;

  @override
  String toString() {
    return 'ConversationMessages(messages: $messages, pagination: $pagination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConversationMessages &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality()
                .equals(other.pagination, pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(pagination));

  @JsonKey(ignore: true)
  @override
  _$$_ConversationMessagesCopyWith<_$_ConversationMessages> get copyWith =>
      __$$_ConversationMessagesCopyWithImpl<_$_ConversationMessages>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationMessagesToJson(this);
  }
}

abstract class _ConversationMessages implements ConversationMessages {
  const factory _ConversationMessages(
      {required final List<PostsOfThreads> messages,
      final Pagination? pagination}) = _$_ConversationMessages;

  factory _ConversationMessages.fromJson(Map<String, dynamic> json) =
      _$_ConversationMessages.fromJson;

  @override
  List<PostsOfThreads> get messages;
  @override
  Pagination? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationMessagesCopyWith<_$_ConversationMessages> get copyWith =>
      throw _privateConstructorUsedError;
}
