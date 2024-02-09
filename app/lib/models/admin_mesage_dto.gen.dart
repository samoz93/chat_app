// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'admin_mesage_dto.dart';

class _$AdminMessageImpl extends AdminMessage {
  _$AdminMessageImpl({
    required this.message,
    this.room,
    required this.receiver,
    required this.sender,
  }) : super.ctor();

  @override
  final String message;

  @override
  final String? room;

  @override
  final String receiver;

  @override
  final String sender;

  factory _$AdminMessageImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$AdminMessageImpl(
      message: json['message'] as String,
      room: json['room'] as String?,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'room': room,
      'receiver': receiver,
      'sender': sender,
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is AdminMessage &&
            runtimeType == other.runtimeType &&
            message == other.message &&
            room == other.room &&
            receiver == other.receiver &&
            sender == other.sender;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      message,
      room,
      receiver,
      sender,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'AdminMessage{<optimized out>}';
    assert(() {
      toStringOutput =
          'AdminMessage@<$hexIdentity>{message: $message, room: $room, receiver: $receiver, sender: $sender}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => AdminMessage;
}

abstract interface class _AdminMessageCopyWithProxy {
  AdminMessage message(String newValue);

  AdminMessage room(String? newValue);

  AdminMessage receiver(String newValue);

  AdminMessage sender(String newValue);

  AdminMessage call({
    final String? message,
    final String? room,
    final String? receiver,
    final String? sender,
  });
}

class _AdminMessageCopyWithProxyImpl implements _AdminMessageCopyWithProxy {
  _AdminMessageCopyWithProxyImpl(this._value);

  final AdminMessage _value;

  @pragma('vm:prefer-inline')
  @override
  AdminMessage message(String newValue) => this(message: newValue);

  @pragma('vm:prefer-inline')
  @override
  AdminMessage room(String? newValue) => this(room: newValue);

  @pragma('vm:prefer-inline')
  @override
  AdminMessage receiver(String newValue) => this(receiver: newValue);

  @pragma('vm:prefer-inline')
  @override
  AdminMessage sender(String newValue) => this(sender: newValue);

  @pragma('vm:prefer-inline')
  @override
  AdminMessage call({
    final String? message,
    final Object? room = const Object(),
    final String? receiver,
    final String? sender,
  }) {
    return _$AdminMessageImpl(
      message: message ?? _value.message,
      room: identical(room, const Object()) ? _value.room : (room as String?),
      receiver: receiver ?? _value.receiver,
      sender: sender ?? _value.sender,
    );
  }
}

sealed class $AdminMessageCopyWithProxyChain<$Result> {
  factory $AdminMessageCopyWithProxyChain(final AdminMessage value,
          final $Result Function(AdminMessage update) chain) =
      _AdminMessageCopyWithProxyChainImpl<$Result>;

  $Result message(String newValue);

  $Result room(String? newValue);

  $Result receiver(String newValue);

  $Result sender(String newValue);

  $Result call({
    final String? message,
    final String? room,
    final String? receiver,
    final String? sender,
  });
}

class _AdminMessageCopyWithProxyChainImpl<$Result>
    implements $AdminMessageCopyWithProxyChain<$Result> {
  _AdminMessageCopyWithProxyChainImpl(this._value, this._chain);

  final AdminMessage _value;
  final $Result Function(AdminMessage update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result message(String newValue) => this(message: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result room(String? newValue) => this(room: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result receiver(String newValue) => this(receiver: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result sender(String newValue) => this(sender: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? message,
    final Object? room = const Object(),
    final String? receiver,
    final String? sender,
  }) {
    return _chain(_$AdminMessageImpl(
      message: message ?? _value.message,
      room: identical(room, const Object()) ? _value.room : (room as String?),
      receiver: receiver ?? _value.receiver,
      sender: sender ?? _value.sender,
    ));
  }
}

extension $AdminMessageExtension on AdminMessage {
  _AdminMessageCopyWithProxy get copyWith =>
      _AdminMessageCopyWithProxyImpl(this);
}
