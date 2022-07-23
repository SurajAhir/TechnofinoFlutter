import 'package:freezed_annotation/freezed_annotation.dart';
part 'AttachmentsData.freezed.dart';
part 'AttachmentsData.g.dart';
@Freezed()
class AttachmentsData with _$AttachmentsData {
  const factory AttachmentsData(
      {
        @Default(0)int attachment_id,
        @Default("")String content_type,
        @Default(0)int file_size,
        @Default("")String filename,
        @Default("")String thumbnail_url,
        @Default("")String direct_url,
        @Default(0)int height,
        @Default(0)int width

      }) = _AttachmentsData;

  factory AttachmentsData.fromJson(Map<String, dynamic> json) =>
      _$AttachmentsDataFromJson(json);
}
