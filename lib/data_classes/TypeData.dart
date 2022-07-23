import 'package:freezed_annotation/freezed_annotation.dart';
part 'TypeData.g.dart';
part 'TypeData.freezed.dart';
@Freezed()
class TypeData with _$TypeData{
  const factory TypeData(
      {
         @Default(0)double last_post_date,
        @Default("") String last_post_username,
         @Default(0)int last_thread_id,
        @Default("") String last_thread_title,
        @Default(0) int message_count,
         @Default(0)int discussion_count,
        @Default(false)bool allow_posting
      }
      )=_TypeData;

  factory TypeData.fromJson(Map<String, dynamic> json
      )
  =>

      _$TypeDataFromJson(json);
}