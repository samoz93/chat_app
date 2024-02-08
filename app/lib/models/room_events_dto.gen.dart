// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'room_events_dto.dart';

class _$RoomsEventsDtoImpl extends RoomsEventsDto {
  _$RoomsEventsDtoImpl({
    required this.room,
    required this.user,
    required this.type,
  }) : super.ctor();

  @override
  final String room;

  @override
  final User user;

  @override
  final String type;

  factory _$RoomsEventsDtoImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$RoomsEventsDtoImpl(
      room: json['room'] as String,
      user: User.fromJson(json['user']),
      type: json['type'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'room': room,
      'user': user.toJson(),
      'type': type,
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is RoomsEventsDto &&
            runtimeType == other.runtimeType &&
            room == other.room &&
            user == other.user &&
            type == other.type;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      room,
      user,
      type,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'RoomsEventsDto{<optimized out>}';
    assert(() {
      toStringOutput =
          'RoomsEventsDto@<$hexIdentity>{room: $room, user: $user, type: $type}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => RoomsEventsDto;
}

abstract interface class _RoomsEventsDtoCopyWithProxy {
  RoomsEventsDto room(String newValue);

  $UserCopyWithProxyChain<RoomsEventsDto> get user;

  RoomsEventsDto type(String newValue);

  RoomsEventsDto call({
    final String? room,
    final User? user,
    final String? type,
  });
}

class _RoomsEventsDtoCopyWithProxyImpl implements _RoomsEventsDtoCopyWithProxy {
  _RoomsEventsDtoCopyWithProxyImpl(this._value);

  final RoomsEventsDto _value;

  @pragma('vm:prefer-inline')
  @override
  RoomsEventsDto room(String newValue) => this(room: newValue);

  @pragma('vm:prefer-inline')
  @override
  $UserCopyWithProxyChain<RoomsEventsDto> get user =>
      $UserCopyWithProxyChain<RoomsEventsDto>(
          _value.user, (User update) => this(user: update));

  @pragma('vm:prefer-inline')
  @override
  RoomsEventsDto type(String newValue) => this(type: newValue);

  @pragma('vm:prefer-inline')
  @override
  RoomsEventsDto call({
    final String? room,
    final User? user,
    final String? type,
  }) {
    return _$RoomsEventsDtoImpl(
      room: room ?? _value.room,
      user: user ?? _value.user,
      type: type ?? _value.type,
    );
  }
}

sealed class $RoomsEventsDtoCopyWithProxyChain<$Result> {
  factory $RoomsEventsDtoCopyWithProxyChain(final RoomsEventsDto value,
          final $Result Function(RoomsEventsDto update) chain) =
      _RoomsEventsDtoCopyWithProxyChainImpl<$Result>;

  $Result room(String newValue);

  $Result user(User newValue);

  $Result type(String newValue);

  $Result call({
    final String? room,
    final User? user,
    final String? type,
  });
}

class _RoomsEventsDtoCopyWithProxyChainImpl<$Result>
    implements $RoomsEventsDtoCopyWithProxyChain<$Result> {
  _RoomsEventsDtoCopyWithProxyChainImpl(this._value, this._chain);

  final RoomsEventsDto _value;
  final $Result Function(RoomsEventsDto update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result room(String newValue) => this(room: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result user(User newValue) => this(user: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result type(String newValue) => this(type: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? room,
    final User? user,
    final String? type,
  }) {
    return _chain(_$RoomsEventsDtoImpl(
      room: room ?? _value.room,
      user: user ?? _value.user,
      type: type ?? _value.type,
    ));
  }
}

extension $RoomsEventsDtoExtension on RoomsEventsDto {
  _RoomsEventsDtoCopyWithProxy get copyWith =>
      _RoomsEventsDtoCopyWithProxyImpl(this);
}
