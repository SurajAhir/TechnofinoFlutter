import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/notification_response/ThreadFromPost.dart';
import 'package:technofino/data_classes/pagination/Pagination.dart';
part 'PostFromNotification.g.dart';

part 'PostFromNotification.freezed.dart';
@Freezed()
class PostFromNotification
    with _$PostFromNotification{

  const factory PostFromNotification
  (
  {
required ThreadFromPost post,
}
)
=
_PostFromNotification;

factory
PostFromNotification.fromJson(

Map<String, dynamic> json
)
=>

_$PostFromNotificationFromJson(json);}