// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AttachmentsData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AttachmentsData _$$_AttachmentsDataFromJson(Map<String, dynamic> json) =>
    _$_AttachmentsData(
      attachment_id: json['attachment_id'] as int? ?? 0,
      content_type: json['content_type'] as String? ?? "",
      file_size: json['file_size'] as int? ?? 0,
      filename: json['filename'] as String? ?? "",
      thumbnail_url: json['thumbnail_url'] as String? ?? "",
      direct_url: json['direct_url'] as String? ?? "",
      height: json['height'] as int? ?? 0,
      width: json['width'] as int? ?? 0,
    );

Map<String, dynamic> _$$_AttachmentsDataToJson(_$_AttachmentsData instance) =>
    <String, dynamic>{
      'attachment_id': instance.attachment_id,
      'content_type': instance.content_type,
      'file_size': instance.file_size,
      'filename': instance.filename,
      'thumbnail_url': instance.thumbnail_url,
      'direct_url': instance.direct_url,
      'height': instance.height,
      'width': instance.width,
    };
