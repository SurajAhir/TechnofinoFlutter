import 'package:freezed_annotation/freezed_annotation.dart';

import '../thread_response/Threads.dart';

part 'ForumData.freezed.dart';
part 'ForumData.g.dart';
@Freezed()
class ForumData with _$ForumData {
  const factory ForumData(
      {
        @Default("")String title})=_ForumData;

  factory ForumData.fromJson(Map<String, dynamic> json) =>
      _$ForumDataFromJson(json);
}
