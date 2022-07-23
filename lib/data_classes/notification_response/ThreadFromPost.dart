import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/Threads.dart';
import 'package:technofino/data_classes/pagination/Pagination.dart';

import 'NotificationsData.dart';
part 'ThreadFromPost.g.dart';

part 'ThreadFromPost.freezed.dart';
@Freezed()
class ThreadFromPost
    with _$ThreadFromPost{

  const factory ThreadFromPost
      (
      {
       required Threads Thread,
        @Default(0)int position
      }
      )
  =
  _ThreadFromPost;

  factory
  ThreadFromPost.fromJson(

      Map<String, dynamic> json
      )
  =>

      _$ThreadFromPostFromJson(json);}