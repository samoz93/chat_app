// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'room_events_dto.dart';

class _$RoomsEventsDtoImpl extends RoomsEventsDto {
  _$RoomsEventsDtoImpl({
    required this.room,
    required List<User> users,
  })  : _users = users,
        super.ctor();

  @override
  final String room;

  @override
  List<User> get users => List<User>.unmodifiable(_users);
  final List<User> _users;

  factory _$RoomsEventsDtoImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$RoomsEventsDtoImpl(
      room: json['room'] as String,
      users: <User>[
        for (final dynamic i0 in (json['users'] as List<dynamic>))
          User.fromJson(i0),
      ],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'room': room,
      'users': <dynamic>[
        for (final User i0 in users) i0.toJson(),
      ],
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is RoomsEventsDto &&
            runtimeType == other.runtimeType &&
            room == other.room &&
            deepEquality(users, other.users);
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      room,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'RoomsEventsDto{<optimized out>}';
    assert(() {
      toStringOutput =
          'RoomsEventsDto@<$hexIdentity>{room: $room, users: $users}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => RoomsEventsDto;
}

abstract interface class _RoomsEventsDtoCopyWithProxy {
  RoomsEventsDto room(String newValue);

  RoomsEventsDto users(List<User> newValue);

  RoomsEventsDto call({
    final String? room,
    final List<User>? users,
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
  RoomsEventsDto users(List<User> newValue) => this(users: newValue);

  @pragma('vm:prefer-inline')
  @override
  RoomsEventsDto call({
    final String? room,
    final List<User>? users,
  }) {
    return _$RoomsEventsDtoImpl(
      room: room ?? _value.room,
      users: users ?? _value.users,
    );
  }
}

sealed class $RoomsEventsDtoCopyWithProxyChain<$Result> {
  factory $RoomsEventsDtoCopyWithProxyChain(final RoomsEventsDto value,
          final $Result Function(RoomsEventsDto update) chain) =
      _RoomsEventsDtoCopyWithProxyChainImpl<$Result>;

  $Result room(String newValue);

  $Result users(List<User> newValue);

  $Result call({
    final String? room,
    final List<User>? users,
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
  $Result users(List<User> newValue) => this(users: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? room,
    final List<User>? users,
  }) {
    return _chain(_$RoomsEventsDtoImpl(
      room: room ?? _value.room,
      users: users ?? _value.users,
    ));
  }
}

extension $RoomsEventsDtoExtension on RoomsEventsDto {
  _RoomsEventsDtoCopyWithProxy get copyWith =>
      _RoomsEventsDtoCopyWithProxyImpl(this);
}
