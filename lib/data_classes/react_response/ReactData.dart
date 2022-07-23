import 'package:freezed_annotation/freezed_annotation.dart';
part 'ReactData.freezed.dart';
part 'ReactData.g.dart';
@Freezed()
class ReactData with _$ReactData {
  const factory ReactData(
      {
        @Default(false)bool success,
        @Default("")String action
      }) = _ReactData;

  factory ReactData.fromJson(Map<String, dynamic> json) =>
      _$ReactDataFromJson(json);
}
