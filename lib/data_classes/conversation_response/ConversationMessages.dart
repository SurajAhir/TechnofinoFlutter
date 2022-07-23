

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/pagination/Pagination.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreads.dart';
part 'ConversationMessages.g.dart';
part 'ConversationMessages.freezed.dart';
@Freezed()
class ConversationMessages with _$ConversationMessages{
  const factory ConversationMessages({
    required List<PostsOfThreads> messages,
    Pagination? pagination
  }) =_ConversationMessages;

  factory ConversationMessages.fromJson(Map<String,dynamic> json)=> _$ConversationMessagesFromJson(json);
}