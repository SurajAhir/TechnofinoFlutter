import 'package:freezed_annotation/freezed_annotation.dart';

import 'Threads.dart';

part 'CreateNewThreadResponse.freezed.dart';
part 'CreateNewThreadResponse.g.dart';
@Freezed()
class CreateNewThreadResponse with _$CreateNewThreadResponse {
  const factory CreateNewThreadResponse(
      {
        required Threads thread,
        @Default(false)bool success}) = _CreateNewThreadResponse;

  factory CreateNewThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateNewThreadResponseFromJson(json);
}
