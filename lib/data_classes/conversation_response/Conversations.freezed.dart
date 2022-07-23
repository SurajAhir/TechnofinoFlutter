// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'Conversations.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Conversations _$ConversationsFromJson(Map<String, dynamic> json) {
  return _Conversations.fromJson(json);
}

/// @nodoc
mixin _$Conversations {
  int get conversation_id => throw _privateConstructorUsedError;
  int get first_message_id => throw _privateConstructorUsedError;
  double get last_message_date => throw _privateConstructorUsedError;
  int get last_message_id => throw _privateConstructorUsedError;
  int get last_message_user_id => throw _privateConstructorUsedError;
  int get recipient_count => throw _privateConstructorUsedError;
  double get start_date => throw _privateConstructorUsedError;
  int get reply_count => throw _privateConstructorUsedError;
  UserData? get Starter => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get user_id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  bool get is_unread => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationsCopyWith<Conversations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationsCopyWith<$Res> {
  factory $ConversationsCopyWith(
          Conversations value, $Res Function(Conversations) then) =
      _$ConversationsCopyWithImpl<$Res>;
  $Res call(
      {int conversation_id,
      int first_message_id,
      double last_message_date,
      int last_message_id,
      int last_message_user_id,
      int recipient_count,
      double start_date,
      int reply_count,
      UserData? Starter,
      String title,
      int user_id,
      String username,
      bool is_unread});

  $UserDataCopyWith<$Res>? get Starter;
}

/// @nodoc
class _$ConversationsCopyWithImpl<$Res>
    implements $ConversationsCopyWith<$Res> {
  _$ConversationsCopyWithImpl(this._value, this._then);

  final Conversations _value;
  // ignore: unused_field
  final $Res Function(Conversations) _then;

  @override
  $Res call({
    Object? conversation_id = freezed,
    Object? first_message_id = freezed,
    Object? last_message_date = freezed,
    Object? last_message_id = freezed,
    Object? last_message_user_id = freezed,
    Object? recipient_count = freezed,
    Object? start_date = freezed,
    Object? reply_count = freezed,
    Object? Starter = freezed,
    Object? title = freezed,
    Object? user_id = freezed,
    Object? username = freezed,
    Object? is_unread = freezed,
  }) {
    return _then(_value.copyWith(
      conversation_id: conversation_id == freezed
          ? _value.conversation_id
          : conversation_id // ignore: cast_nullable_to_non_nullable
              as int,
      first_message_id: first_message_id == freezed
          ? _value.first_message_id
          : first_message_id // ignore: cast_nullable_to_non_nullable
              as int,
      last_message_date: last_message_date == freezed
          ? _value.last_message_date
          : last_message_date // ignore: cast_nullable_to_non_nullable
              as double,
      last_message_id: last_message_id == freezed
          ? _value.last_message_id
          : last_message_id // ignore: cast_nullable_to_non_nullable
              as int,
      last_message_user_id: last_message_user_id == freezed
          ? _value.last_message_user_id
          : last_message_user_id // ignore: cast_nullable_to_non_nullable
              as int,
      recipient_count: recipient_count == freezed
          ? _value.recipient_count
          : recipient_count // ignore: cast_nullable_to_non_nullable
              as int,
      start_date: start_date == freezed
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as double,
      reply_count: reply_count == freezed
          ? _value.reply_count
          : reply_count // ignore: cast_nullable_to_non_nullable
              as int,
      Starter: Starter == freezed
          ? _value.Starter
          : Starter // ignore: cast_nullable_to_non_nullable
              as UserData?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: user_id == freezed
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      is_unread: is_unread == freezed
          ? _value.is_unread
          : is_unread // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $UserDataCopyWith<$Res>? get Starter {
    if (_value.Starter == null) {
      return null;
    }

    return $UserDataCopyWith<$Res>(_value.Starter!, (value) {
      return _then(_value.copyWith(Starter: value));
    });
  }
}

/// @nodoc
abstract class _$$_ConversationsCopyWith<$Res>
    implements $ConversationsCopyWith<$Res> {
  factory _$$_ConversationsCopyWith(
          _$_Conversations value, $Res Function(_$_Conversations) then) =
      __$$_ConversationsCopyWithImpl<$Res>;
  @override
  $Res call(
      {int conversation_id,
      int first_message_id,
      double last_message_date,
      int last_message_id,
      int last_message_user_id,
      int recipient_count,
      double start_date,
      int reply_count,
      UserData? Starter,
      String title,
      int user_id,
      String username,
      bool is_unread});

  @override
  $UserDataCopyWith<$Res>? get Starter;
}

/// @nodoc
class __$$_ConversationsCopyWithImpl<$Res>
    extends _$ConversationsCopyWithImpl<$Res>
    implements _$$_ConversationsCopyWith<$Res> {
  __$$_ConversationsCopyWithImpl(
      _$_Conversations _value, $Res Function(_$_Conversations) _then)
      : super(_value, (v) => _then(v as _$_Conversations));

  @override
  _$_Conversations get _value => super._value as _$_Conversations;

  @override
  $Res call({
    Object? conversation_id = freezed,
    Object? first_message_id = freezed,
    Object? last_message_date = freezed,
    Object? last_message_id = freezed,
    Object? last_message_user_id = freezed,
    Object? recipient_count = freezed,
    Object? start_date = freezed,
    Object? reply_count = freezed,
    Object? Starter = freezed,
    Object? title = freezed,
    Object? user_id = freezed,
    Object? username = freezed,
    Object? is_unread = freezed,
  }) {
    return _then(_$_Conversations(
      conversation_id: conversation_id == freezed
          ? _value.conversation_id
          : conversation_id // ignore: cast_nullable_to_non_nullable
              as int,
      first_message_id: first_message_id == freezed
          ? _value.first_message_id
          : first_message_id // ignore: cast_nullable_to_non_nullable
              as int,
      last_message_date: last_message_date == freezed
          ? _value.last_message_date
          : last_message_date // ignore: cast_nullable_to_non_nullable
              as double,
      last_message_id: last_message_id == freezed
          ? _value.last_message_id
          : last_message_id // ignore: cast_nullable_to_non_nullable
              as int,
      last_message_user_id: last_message_user_id == freezed
          ? _value.last_message_user_id
          : last_message_user_id // ignore: cast_nullable_to_non_nullable
              as int,
      recipient_count: recipient_count == freezed
          ? _value.recipient_count
          : recipient_count // ignore: cast_nullable_to_non_nullable
              as int,
      start_date: start_date == freezed
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as double,
      reply_count: reply_count == freezed
          ? _value.reply_count
          : reply_count // ignore: cast_nullable_to_non_nullable
              as int,
      Starter: Starter == freezed
          ? _value.Starter
          : Starter // ignore: cast_nullable_to_non_nullable
              as UserData?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: user_id == freezed
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      is_unread: is_unread == freezed
          ? _value.is_unread
          : is_unread // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Conversations implements _Conversations {
  const _$_Conversations(
      {this.conversation_id = 0,
      this.first_message_id = 0,
      this.last_message_date = 0,
      this.last_message_id = 0,
      this.last_message_user_id = 0,
      this.recipient_count = 0,
      this.start_date = 0,
      this.reply_count = 0,
      this.Starter,
      this.title = "",
      this.user_id = 0,
      this.username = "",
      this.is_unread = false});

  factory _$_Conversations.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationsFromJson(json);

  @override
  @JsonKey()
  final int conversation_id;
  @override
  @JsonKey()
  final int first_message_id;
  @override
  @JsonKey()
  final double last_message_date;
  @override
  @JsonKey()
  final int last_message_id;
  @override
  @JsonKey()
  final int last_message_user_id;
  @override
  @JsonKey()
  final int recipient_count;
  @override
  @JsonKey()
  final double start_date;
  @override
  @JsonKey()
  final int reply_count;
  @override
  final UserData? Starter;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final int user_id;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final bool is_unread;

  @override
  String toString() {
    return 'Conversations(conversation_id: $conversation_id, first_message_id: $first_message_id, last_message_date: $last_message_date, last_message_id: $last_message_id, last_message_user_id: $last_message_user_id, recipient_count: $recipient_count, start_date: $start_date, reply_count: $reply_count, Starter: $Starter, title: $title, user_id: $user_id, username: $username, is_unread: $is_unread)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Conversations &&
            const DeepCollectionEquality()
                .equals(other.conversation_id, conversation_id) &&
            const DeepCollectionEquality()
                .equals(other.first_message_id, first_message_id) &&
            const DeepCollectionEquality()
                .equals(other.last_message_date, last_message_date) &&
            const DeepCollectionEquality()
                .equals(other.last_message_id, last_message_id) &&
            const DeepCollectionEquality()
                .equals(other.last_message_user_id, last_message_user_id) &&
            const DeepCollectionEquality()
                .equals(other.recipient_count, recipient_count) &&
            const DeepCollectionEquality()
                .equals(other.start_date, start_date) &&
            const DeepCollectionEquality()
                .equals(other.reply_count, reply_count) &&
            const DeepCollectionEquality().equals(other.Starter, Starter) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.user_id, user_id) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.is_unread, is_unread));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(conversation_id),
      const DeepCollectionEquality().hash(first_message_id),
      const DeepCollectionEquality().hash(last_message_date),
      const DeepCollectionEquality().hash(last_message_id),
      const DeepCollectionEquality().hash(last_message_user_id),
      const DeepCollectionEquality().hash(recipient_count),
      const DeepCollectionEquality().hash(start_date),
      const DeepCollectionEquality().hash(reply_count),
      const DeepCollectionEquality().hash(Starter),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(user_id),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(is_unread));

  @JsonKey(ignore: true)
  @override
  _$$_ConversationsCopyWith<_$_Conversations> get copyWith =>
      __$$_ConversationsCopyWithImpl<_$_Conversations>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationsToJson(this);
  }
}

abstract class _Conversations implements Conversations {
  const factory _Conversations(
      {final int conversation_id,
      final int first_message_id,
      final double last_message_date,
      final int last_message_id,
      final int last_message_user_id,
      final int recipient_count,
      final double start_date,
      final int reply_count,
      final UserData? Starter,
      final String title,
      final int user_id,
      final String username,
      final bool is_unread}) = _$_Conversations;

  factory _Conversations.fromJson(Map<String, dynamic> json) =
      _$_Conversations.fromJson;

  @override
  int get conversation_id;
  @override
  int get first_message_id;
  @override
  double get last_message_date;
  @override
  int get last_message_id;
  @override
  int get last_message_user_id;
  @override
  int get recipient_count;
  @override
  double get start_date;
  @override
  int get reply_count;
  @override
  UserData? get Starter;
  @override
  String get title;
  @override
  int get user_id;
  @override
  String get username;
  @override
  bool get is_unread;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationsCopyWith<_$_Conversations> get copyWith =>
      throw _privateConstructorUsedError;
}
