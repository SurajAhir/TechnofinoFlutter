
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/forume_data/ForumResponse.dart';

import '../login_response/UserData.dart';

part 'Threads.g.dart';
part 'Threads.freezed.dart';
@Freezed()
class Threads with _$Threads {
  const factory Threads
      (
      { @Default("") String last_post_username,
        @Default("") String title,
        @Default(0) int reply_count,
        @Default(0) double post_date,
        @Default(0)int last_post_id,
        required UserData User,
        @Default(0) int thread_id,
        @Default(0) double last_post_date,
        @Default("") String username,
        @Default(0) int view_count,
        @Default("")String view_url,
        ForumResponse? Forum
      })=
  _Threads;

  factory
  Threads.fromJson(

      Map<String, dynamic> json
      )
  =>

      _$ThreadsFromJson(json);

}