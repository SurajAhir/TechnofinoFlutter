import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'Avatar_Urls.g.dart';

part 'Avatar_Urls.freezed.dart';

@Freezed()
class Avatar_Urls with _$Avatar_Urls {
  const factory Avatar_Urls
  (
  { @Default("") String o,
  @Default("") String h,
  @Default("") String l,
  @Default("") String m,
  @Default("") String s})=
_Avatar_Urls;

factory
Avatar_Urls.fromJson(

Map<String, dynamic> json
)
=>

_$Avatar_UrlsFromJson(json);

}