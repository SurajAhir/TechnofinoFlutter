
import 'package:freezed_annotation/freezed_annotation.dart';

import '../login_response/UserData.dart';

part 'Conversations.g.dart';
part 'Conversations.freezed.dart';
@Freezed()
class Conversations with _$Conversations{
  const factory Conversations({
    @Default(0)int conversation_id,
    @Default(0)int first_message_id,
    @Default(0)double last_message_date,
    @Default(0)int last_message_id,
    @Default(0)int last_message_user_id,
    @Default(0)int recipient_count,
    @Default(0)double start_date,
    @Default(0)int reply_count,
    UserData? Starter,
    @Default("")String title,
    @Default(0)int user_id,
    @Default("")String username,
    @Default("")String view_url,
    @Default(false)bool is_starred,
    @Default(false)bool is_unread

  }) =_Conversations;

  factory Conversations.fromJson(Map<String,dynamic> json)=> _$ConversationsFromJson(json);
}