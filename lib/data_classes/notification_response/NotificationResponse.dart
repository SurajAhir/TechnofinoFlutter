import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/pagination/Pagination.dart';

import 'NotificationsData.dart';
part 'NotificationResponse.g.dart';

part 'NotificationResponse.freezed.dart';
@Freezed()
class NotificationResponse
    with _$NotificationResponse{

  const factory NotificationResponse
      (
      {
      required List<NotificationsData> alerts,
        Pagination? pagination
      }
      )
  =
  _NotificationResponse;

  factory
  NotificationResponse.fromJson(

      Map<String, dynamic> json
      )
  =>

      _$NotificationResponseFromJson(json);}