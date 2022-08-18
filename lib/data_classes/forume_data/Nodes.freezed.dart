// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'Nodes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Nodes _$NodesFromJson(Map<String, dynamic> json) {
  return _Nodes.fromJson(json);
}

/// @nodoc
mixin _$Nodes {
  String get title => throw _privateConstructorUsedError;
  String get view_url => throw _privateConstructorUsedError;
  TypeData get type_data => throw _privateConstructorUsedError;
  int get parent_node_id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get node_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodesCopyWith<Nodes> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodesCopyWith<$Res> {
  factory $NodesCopyWith(Nodes value, $Res Function(Nodes) then) =
      _$NodesCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String view_url,
      TypeData type_data,
      int parent_node_id,
      String description,
      int node_id});

  $TypeDataCopyWith<$Res> get type_data;
}

/// @nodoc
class _$NodesCopyWithImpl<$Res> implements $NodesCopyWith<$Res> {
  _$NodesCopyWithImpl(this._value, this._then);

  final Nodes _value;
  // ignore: unused_field
  final $Res Function(Nodes) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? view_url = freezed,
    Object? type_data = freezed,
    Object? parent_node_id = freezed,
    Object? description = freezed,
    Object? node_id = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      view_url: view_url == freezed
          ? _value.view_url
          : view_url // ignore: cast_nullable_to_non_nullable
              as String,
      type_data: type_data == freezed
          ? _value.type_data
          : type_data // ignore: cast_nullable_to_non_nullable
              as TypeData,
      parent_node_id: parent_node_id == freezed
          ? _value.parent_node_id
          : parent_node_id // ignore: cast_nullable_to_non_nullable
              as int,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      node_id: node_id == freezed
          ? _value.node_id
          : node_id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $TypeDataCopyWith<$Res> get type_data {
    return $TypeDataCopyWith<$Res>(_value.type_data, (value) {
      return _then(_value.copyWith(type_data: value));
    });
  }
}

/// @nodoc
abstract class _$$_NodesCopyWith<$Res> implements $NodesCopyWith<$Res> {
  factory _$$_NodesCopyWith(_$_Nodes value, $Res Function(_$_Nodes) then) =
      __$$_NodesCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String view_url,
      TypeData type_data,
      int parent_node_id,
      String description,
      int node_id});

  @override
  $TypeDataCopyWith<$Res> get type_data;
}

/// @nodoc
class __$$_NodesCopyWithImpl<$Res> extends _$NodesCopyWithImpl<$Res>
    implements _$$_NodesCopyWith<$Res> {
  __$$_NodesCopyWithImpl(_$_Nodes _value, $Res Function(_$_Nodes) _then)
      : super(_value, (v) => _then(v as _$_Nodes));

  @override
  _$_Nodes get _value => super._value as _$_Nodes;

  @override
  $Res call({
    Object? title = freezed,
    Object? view_url = freezed,
    Object? type_data = freezed,
    Object? parent_node_id = freezed,
    Object? description = freezed,
    Object? node_id = freezed,
  }) {
    return _then(_$_Nodes(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      view_url: view_url == freezed
          ? _value.view_url
          : view_url // ignore: cast_nullable_to_non_nullable
              as String,
      type_data: type_data == freezed
          ? _value.type_data
          : type_data // ignore: cast_nullable_to_non_nullable
              as TypeData,
      parent_node_id: parent_node_id == freezed
          ? _value.parent_node_id
          : parent_node_id // ignore: cast_nullable_to_non_nullable
              as int,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      node_id: node_id == freezed
          ? _value.node_id
          : node_id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Nodes implements _Nodes {
  const _$_Nodes(
      {this.title = "",
      this.view_url = "",
      required this.type_data,
      this.parent_node_id = 0,
      this.description = "",
      this.node_id = 0});

  factory _$_Nodes.fromJson(Map<String, dynamic> json) =>
      _$$_NodesFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String view_url;
  @override
  final TypeData type_data;
  @override
  @JsonKey()
  final int parent_node_id;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int node_id;

  @override
  String toString() {
    return 'Nodes(title: $title, view_url: $view_url, type_data: $type_data, parent_node_id: $parent_node_id, description: $description, node_id: $node_id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Nodes &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.view_url, view_url) &&
            const DeepCollectionEquality().equals(other.type_data, type_data) &&
            const DeepCollectionEquality()
                .equals(other.parent_node_id, parent_node_id) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.node_id, node_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(view_url),
      const DeepCollectionEquality().hash(type_data),
      const DeepCollectionEquality().hash(parent_node_id),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(node_id));

  @JsonKey(ignore: true)
  @override
  _$$_NodesCopyWith<_$_Nodes> get copyWith =>
      __$$_NodesCopyWithImpl<_$_Nodes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NodesToJson(this);
  }
}

abstract class _Nodes implements Nodes {
  const factory _Nodes(
      {final String title,
      final String view_url,
      required final TypeData type_data,
      final int parent_node_id,
      final String description,
      final int node_id}) = _$_Nodes;

  factory _Nodes.fromJson(Map<String, dynamic> json) = _$_Nodes.fromJson;

  @override
  String get title;
  @override
  String get view_url;
  @override
  TypeData get type_data;
  @override
  int get parent_node_id;
  @override
  String get description;
  @override
  int get node_id;
  @override
  @JsonKey(ignore: true)
  _$$_NodesCopyWith<_$_Nodes> get copyWith =>
      throw _privateConstructorUsedError;
}
