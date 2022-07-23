import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/UserData.dart';
part 'NotificationsData.g.dart';

part 'NotificationsData.freezed.dart';
@Freezed()
class NotificationsData
    with _$NotificationsData{

  const factory NotificationsData
      (
      {
        @Default("")String action,
        @Default(0)int alert_id,
        @Default("")String alert_text,
        @Default(0)int alerted_user_id,
        UserData? User,
        @Default(0)double event_date,
        @Default(0)double view_date,
        @Default(0)int content_id,
        @Default(0)double read_date
      }
      )
  =
  _NotificationsData;

  factory
  NotificationsData.fromJson(

      Map<String, dynamic> json
      )
  =>

      _$NotificationsDataFromJson(json);}