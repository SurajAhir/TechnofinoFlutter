// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'NodeResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NodeResponse _$NodeResponseFromJson(Map<String, dynamic> json) {
  return _NodeResponse.fromJson(json);
}

/// @nodoc
mixin _$NodeResponse {
  List<Nodes> get nodes => throw _privateConstructorUsedError;
  Map<String, List<int>>? get tree_map => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeResponseCopyWith<NodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeResponseCopyWith<$Res> {
  factory $NodeResponseCopyWith(
          NodeResponse value, $Res Function(NodeResponse) then) =
      _$NodeResponseCopyWithImpl<$Res>;
  $Res call({List<Nodes> nodes, Map<String, List<int>>? tree_map});
}

/// @nodoc
class _$NodeResponseCopyWithImpl<$Res> implements $NodeResponseCopyWith<$Res> {
  _$NodeResponseCopyWithImpl(this._value, this._then);

  final NodeResponse _value;
  // ignore: unused_field
  final $Res Function(NodeResponse) _then;

  @override
  $Res call({
    Object? nodes = freezed,
    Object? tree_map = freezed,
  }) {
    return _then(_value.copyWith(
      nodes: nodes == freezed
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<Nodes>,
      tree_map: tree_map == freezed
          ? _value.tree_map
          : tree_map // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>?,
    ));
  }
}

/// @nodoc
abstract class _$$_NodeResponseCopyWith<$Res>
    implements $NodeResponseCopyWith<$Res> {
  factory _$$_NodeResponseCopyWith(
          _$_NodeResponse value, $Res Function(_$_NodeResponse) then) =
      __$$_NodeResponseCopyWithImpl<$Res>;
  @override
  $Res call({List<Nodes> nodes, Map<String, List<int>>? tree_map});
}

/// @nodoc
class __$$_NodeResponseCopyWithImpl<$Res>
    extends _$NodeResponseCopyWithImpl<$Res>
    implements _$$_NodeResponseCopyWith<$Res> {
  __$$_NodeResponseCopyWithImpl(
      _$_NodeResponse _value, $Res Function(_$_NodeResponse) _then)
      : super(_value, (v) => _then(v as _$_NodeResponse));

  @override
  _$_NodeResponse get _value => super._value as _$_NodeResponse;

  @override
  $Res call({
    Object? nodes = freezed,
    Object? tree_map = freezed,
  }) {
    return _then(_$_NodeResponse(
      nodes: nodes == freezed
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<Nodes>,
      tree_map: tree_map == freezed
          ? _value._tree_map
          : tree_map // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NodeResponse implements _NodeResponse {
  const _$_NodeResponse(
      {required final List<Nodes> nodes,
      final Map<String, List<int>>? tree_map})
      : _nodes = nodes,
        _tree_map = tree_map;

  factory _$_NodeResponse.fromJson(Map<String, dynamic> json) =>
      _$$_NodeResponseFromJson(json);

  final List<Nodes> _nodes;
  @override
  List<Nodes> get nodes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  final Map<String, List<int>>? _tree_map;
  @override
  Map<String, List<int>>? get tree_map {
    final value = _tree_map;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'NodeResponse(nodes: $nodes, tree_map: $tree_map)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NodeResponse &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality().equals(other._tree_map, _tree_map));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_nodes),
      const DeepCollectionEquality().hash(_tree_map));

  @JsonKey(ignore: true)
  @override
  _$$_NodeResponseCopyWith<_$_NodeResponse> get copyWith =>
      __$$_NodeResponseCopyWithImpl<_$_NodeResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NodeResponseToJson(this);
  }
}

abstract class _NodeResponse implements NodeResponse {
  const factory _NodeResponse(
      {required final List<Nodes> nodes,
      final Map<String, List<int>>? tree_map}) = _$_NodeResponse;

  factory _NodeResponse.fromJson(Map<String, dynamic> json) =
      _$_NodeResponse.fromJson;

  @override
  List<Nodes> get nodes;
  @override
  Map<String, List<int>>? get tree_map;
  @override
  @JsonKey(ignore: true)
  _$$_NodeResponseCopyWith<_$_NodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
