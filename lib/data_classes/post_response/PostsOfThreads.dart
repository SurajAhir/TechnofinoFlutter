import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/UserData.dart';

import '../attachment_response/AttachmentsData.dart';
import 'TapiReaction.dart';

part 'PostsOfThreads.freezed.dart';

part 'PostsOfThreads.g.dart';

@Freezed()
class PostsOfThreads with _$PostsOfThreads {
  const factory PostsOfThreads({
    @Default("")String message,
    @Default("")String message_parsed,
    @Default(0)int position,
    @Default(0)double message_date,
    @Default(0)double post_date,
    @Default(0)int thread_id,
    @Default(0)int user_id,
    @Default(0)int post_id,
    @Default(false)bool is_reacted_to,
    @Default(0)int visitor_reaction_id,
    @Default(0)int reaction_score,
     UserData? User,
    List<TapiReaction>? tapi_reactions,
    @Default(0)int conversation_id,
    @Default(0)int message_id,
    @Default(0)int attach_count,
   @Default(false) bool is_staff,
   @Default(false) bool is_admin,
   @Default(false) bool is_super_admin,
    List<AttachmentsData>? Attachments
})=_PostsOfThreads;

factory PostsOfThreads.fromJson(Map<String, dynamic> json)=>_$PostsOfThreadsFromJson(json);
}
