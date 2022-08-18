import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technofino/data_classes/login_response/UserData.dart';

part 'FilterData.freezed.dart';
part 'FilterData.g.dart';
@Freezed()
class FilterData with _$FilterData {
  const factory FilterData(
      {
        UserData? exact,
        List<UserData>? recommendations
      }) = _ThreadResponse;

  factory FilterData.fromJson(Map<String, dynamic> json) =>
      _$FilterDataFromJson(json);
}
