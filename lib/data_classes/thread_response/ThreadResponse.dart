import 'package:freezed_annotation/freezed_annotation.dart';

import '../Threads.dart';
import '../pagination/Pagination.dart';

part 'ThreadResponse.freezed.dart';
part 'ThreadResponse.g.dart';
@Freezed()
class ThreadResponse with _$ThreadResponse {
  const factory ThreadResponse(
      {
        required List<Threads> threads,
        List<Threads>? sticky,
      Pagination? pagination}) = _ThreadResponse;

  factory ThreadResponse.fromJson(Map<String, dynamic> json) =>
      _$ThreadResponseFromJson(json);
}
