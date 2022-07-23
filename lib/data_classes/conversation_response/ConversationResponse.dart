

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/pagination/Pagination.dart';

import 'Conversations.dart';
part 'ConversationResponse.g.dart';
part 'ConversationResponse.freezed.dart';
@Freezed()
class ConversationResponse with _$ConversationResponse{
  const factory ConversationResponse({
   required List<Conversations> conversations,
    Pagination? pagination
}) =_ConversationResponse;

  factory ConversationResponse.fromJson(Map<String,dynamic> json)=> _$ConversationResponseFromJson(json);
}