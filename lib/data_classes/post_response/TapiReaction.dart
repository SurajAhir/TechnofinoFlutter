import 'package:freezed_annotation/freezed_annotation.dart';
part 'TapiReaction.freezed.dart';
part 'TapiReaction.g.dart';
@Freezed()
class TapiReaction with _$TapiReaction {
  const factory TapiReaction(
      {
       @Default("")String image,
        @Default(0)int total
        
      }) = _TapiReaction;

  factory TapiReaction.fromJson(Map<String, dynamic> json) =>
      _$TapiReactionFromJson(json);
}
