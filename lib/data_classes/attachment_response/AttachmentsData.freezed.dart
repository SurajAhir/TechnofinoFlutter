// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'AttachmentsData.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttachmentsData _$AttachmentsDataFromJson(Map<String, dynamic> json) {
  return _AttachmentsData.fromJson(json);
}

/// @nodoc
mixin _$AttachmentsData {
  int get attachment_id => throw _privateConstructorUsedError;
  String get content_type => throw _privateConstructorUsedError;
  int get file_size => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  String get thumbnail_url => throw _privateConstructorUsedError;
  String get direct_url => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachmentsDataCopyWith<AttachmentsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentsDataCopyWith<$Res> {
  factory $AttachmentsDataCopyWith(
          AttachmentsData value, $Res Function(AttachmentsData) then) =
      _$AttachmentsDataCopyWithImpl<$Res>;
  $Res call(
      {int attachment_id,
      String content_type,
      int file_size,
      String filename,
      String thumbnail_url,
      String direct_url,
      int height,
      int width});
}

/// @nodoc
class _$AttachmentsDataCopyWithImpl<$Res>
    implements $AttachmentsDataCopyWith<$Res> {
  _$AttachmentsDataCopyWithImpl(this._value, this._then);

  final AttachmentsData _value;
  // ignore: unused_field
  final $Res Function(AttachmentsData) _then;

  @override
  $Res call({
    Object? attachment_id = freezed,
    Object? content_type = freezed,
    Object? file_size = freezed,
    Object? filename = freezed,
    Object? thumbnail_url = freezed,
    Object? direct_url = freezed,
    Object? height = freezed,
    Object? width = freezed,
  }) {
    return _then(_value.copyWith(
      attachment_id: attachment_id == freezed
          ? _value.attachment_id
          : attachment_id // ignore: cast_nullable_to_non_nullable
              as int,
      content_type: content_type == freezed
          ? _value.content_type
          : content_type // ignore: cast_nullable_to_non_nullable
              as String,
      file_size: file_size == freezed
          ? _value.file_size
          : file_size // ignore: cast_nullable_to_non_nullable
              as int,
      filename: filename == freezed
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail_url: thumbnail_url == freezed
          ? _value.thumbnail_url
          : thumbnail_url // ignore: cast_nullable_to_non_nullable
              as String,
      direct_url: direct_url == freezed
          ? _value.direct_url
          : direct_url // ignore: cast_nullable_to_non_nullable
              as String,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_AttachmentsDataCopyWith<$Res>
    implements $AttachmentsDataCopyWith<$Res> {
  factory _$$_AttachmentsDataCopyWith(
          _$_AttachmentsData value, $Res Function(_$_AttachmentsData) then) =
      __$$_AttachmentsDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {int attachment_id,
      String content_type,
      int file_size,
      String filename,
      String thumbnail_url,
      String direct_url,
      int height,
      int width});
}

/// @nodoc
class __$$_AttachmentsDataCopyWithImpl<$Res>
    extends _$AttachmentsDataCopyWithImpl<$Res>
    implements _$$_AttachmentsDataCopyWith<$Res> {
  __$$_AttachmentsDataCopyWithImpl(
      _$_AttachmentsData _value, $Res Function(_$_AttachmentsData) _then)
      : super(_value, (v) => _then(v as _$_AttachmentsData));

  @override
  _$_AttachmentsData get _value => super._value as _$_AttachmentsData;

  @override
  $Res call({
    Object? attachment_id = freezed,
    Object? content_type = freezed,
    Object? file_size = freezed,
    Object? filename = freezed,
    Object? thumbnail_url = freezed,
    Object? direct_url = freezed,
    Object? height = freezed,
    Object? width = freezed,
  }) {
    return _then(_$_AttachmentsData(
      attachment_id: attachment_id == freezed
          ? _value.attachment_id
          : attachment_id // ignore: cast_nullable_to_non_nullable
              as int,
      content_type: content_type == freezed
          ? _value.content_type
          : content_type // ignore: cast_nullable_to_non_nullable
              as String,
      file_size: file_size == freezed
          ? _value.file_size
          : file_size // ignore: cast_nullable_to_non_nullable
              as int,
      filename: filename == freezed
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail_url: thumbnail_url == freezed
          ? _value.thumbnail_url
          : thumbnail_url // ignore: cast_nullable_to_non_nullable
              as String,
      direct_url: direct_url == freezed
          ? _value.direct_url
          : direct_url // ignore: cast_nullable_to_non_nullable
              as String,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttachmentsData implements _AttachmentsData {
  const _$_AttachmentsData(
      {this.attachment_id = 0,
      this.content_type = "",
      this.file_size = 0,
      this.filename = "",
      this.thumbnail_url = "",
      this.direct_url = "",
      this.height = 0,
      this.width = 0});

  factory _$_AttachmentsData.fromJson(Map<String, dynamic> json) =>
      _$$_AttachmentsDataFromJson(json);

  @override
  @JsonKey()
  final int attachment_id;
  @override
  @JsonKey()
  final String content_type;
  @override
  @JsonKey()
  final int file_size;
  @override
  @JsonKey()
  final String filename;
  @override
  @JsonKey()
  final String thumbnail_url;
  @override
  @JsonKey()
  final String direct_url;
  @override
  @JsonKey()
  final int height;
  @override
  @JsonKey()
  final int width;

  @override
  String toString() {
    return 'AttachmentsData(attachment_id: $attachment_id, content_type: $content_type, file_size: $file_size, filename: $filename, thumbnail_url: $thumbnail_url, direct_url: $direct_url, height: $height, width: $width)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttachmentsData &&
            const DeepCollectionEquality()
                .equals(other.attachment_id, attachment_id) &&
            const DeepCollectionEquality()
                .equals(other.content_type, content_type) &&
            const DeepCollectionEquality().equals(other.file_size, file_size) &&
            const DeepCollectionEquality().equals(other.filename, filename) &&
            const DeepCollectionEquality()
                .equals(other.thumbnail_url, thumbnail_url) &&
            const DeepCollectionEquality()
                .equals(other.direct_url, direct_url) &&
            const DeepCollectionEquality().equals(other.height, height) &&
            const DeepCollectionEquality().equals(other.width, width));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(attachment_id),
      const DeepCollectionEquality().hash(content_type),
      const DeepCollectionEquality().hash(file_size),
      const DeepCollectionEquality().hash(filename),
      const DeepCollectionEquality().hash(thumbnail_url),
      const DeepCollectionEquality().hash(direct_url),
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(width));

  @JsonKey(ignore: true)
  @override
  _$$_AttachmentsDataCopyWith<_$_AttachmentsData> get copyWith =>
      __$$_AttachmentsDataCopyWithImpl<_$_AttachmentsData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttachmentsDataToJson(this);
  }
}

abstract class _AttachmentsData implements AttachmentsData {
  const factory _AttachmentsData(
      {final int attachment_id,
      final String content_type,
      final int file_size,
      final String filename,
      final String thumbnail_url,
      final String direct_url,
      final int height,
      final int width}) = _$_AttachmentsData;

  factory _AttachmentsData.fromJson(Map<String, dynamic> json) =
      _$_AttachmentsData.fromJson;

  @override
  int get attachment_id;
  @override
  String get content_type;
  @override
  int get file_size;
  @override
  String get filename;
  @override
  String get thumbnail_url;
  @override
  String get direct_url;
  @override
  int get height;
  @override
  int get width;
  @override
  @JsonKey(ignore: true)
  _$$_AttachmentsDataCopyWith<_$_AttachmentsData> get copyWith =>
      throw _privateConstructorUsedError;
}
