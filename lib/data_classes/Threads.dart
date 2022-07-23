
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/UserData.dart';
import 'package:technofino/data_classes/forume_data/ForumResponse.dart';
import 'UserData.dart';

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
        required UserData User,
        @Default(0) int thread_id,
        @Default(0) double last_post_date,
        @Default("") String username,
        @Default(0) int view_count,
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