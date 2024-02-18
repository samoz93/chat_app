// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'room_dto.dart';

class _$RoomDtoImpl extends RoomDto {
  _$RoomDtoImpl({
    required this.id,
    required this.name,
    required this.description,
  }) : super.ctor();

  @override
  final String id;

  @override
  final String name;

  @override
  final String description;

  factory _$RoomDtoImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$RoomDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is RoomDto &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            description == other.description;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      id,
      name,
      description,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'RoomDto{<optimized out>}';
    assert(() {
      toStringOutput =
          'RoomDto@<$hexIdentity>{id: $id, name: $name, description: $description}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => RoomDto;
}

abstract interface class _RoomDtoCopyWithProxy {
  RoomDto id(String newValue);

  RoomDto name(String newValue);

  RoomDto description(String newValue);

  RoomDto call({
    final String? id,
    final String? name,
    final String? description,
  });
}

class _RoomDtoCopyWithProxyImpl implements _RoomDtoCopyWithProxy {
  _RoomDtoCopyWithProxyImpl(this._value);

  final RoomDto _value;

  @pragma('vm:prefer-inline')
  @override
  RoomDto id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  @override
  RoomDto name(String newValue) => this(name: newValue);

  @pragma('vm:prefer-inline')
  @override
  RoomDto description(String newValue) => this(description: newValue);

  @pragma('vm:prefer-inline')
  @override
  RoomDto call({
    final String? id,
    final String? name,
    final String? description,
  }) {
    return _$RoomDtoImpl(
      id: id ?? _value.id,
      name: name ?? _value.name,
      description: description ?? _value.description,
    );
  }
}

sealed class $RoomDtoCopyWithProxyChain<$Result> {
  factory $RoomDtoCopyWithProxyChain(
          final RoomDto value, final $Result Function(RoomDto update) chain) =
      _RoomDtoCopyWithProxyChainImpl<$Result>;

  $Result id(String newValue);

  $Result name(String newValue);

  $Result description(String newValue);

  $Result call({
    final String? id,
    final String? name,
    final String? description,
  });
}

class _RoomDtoCopyWithProxyChainImpl<$Result>
    implements $RoomDtoCopyWithProxyChain<$Result> {
  _RoomDtoCopyWithProxyChainImpl(this._value, this._chain);

  final RoomDto _value;
  final $Result Function(RoomDto update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result name(String newValue) => this(name: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result description(String newValue) => this(description: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? id,
    final String? name,
    final String? description,
  }) {
    return _chain(_$RoomDtoImpl(
      id: id ?? _value.id,
      name: name ?? _value.name,
      description: description ?? _value.description,
    ));
  }
}

extension $RoomDtoExtension on RoomDto {
  _RoomDtoCopyWithProxy get copyWith => _RoomDtoCopyWithProxyImpl(this);
}
