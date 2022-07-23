import 'package:freezed_annotation/freezed_annotation.dart';

import 'UserData.dart';

part 'LoginResponse.freezed.dart';
part 'LoginResponse.g.dart';
@Freezed()
class LoginResponse with _$LoginResponse {
  const factory LoginResponse(
      {
      required bool success,
      required UserData user,}) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
