// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'message_dto.dart';

class _$MessageDtoImpl extends MessageDto {
  _$MessageDtoImpl({
    required this.message,
    required this.sender,
    required this.receiver,
    this.room,
  }) : super.ctor();

  @override
  final String message;

  @override
  final String sender;

  @override
  final String receiver;

  @override
  final String? room;

  factory _$MessageDtoImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$MessageDtoImpl(
      message: json['message'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      room: json['room'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'room': room,
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is MessageDto &&
            runtimeType == other.runtimeType &&
            message == other.message &&
            sender == other.sender &&
            receiver == other.receiver &&
            room == other.room;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      message,
      sender,
      receiver,
      room,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'MessageDto{<optimized out>}';
    assert(() {
      toStringOutput =
          'MessageDto@<$hexIdentity>{message: $message, sender: $sender, receiver: $receiver, room: $room}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => MessageDto;
}

abstract interface class _MessageDtoCopyWithProxy {
  MessageDto message(String newValue);

  MessageDto sender(String newValue);

  MessageDto receiver(String newValue);

  MessageDto room(String? newValue);

  MessageDto call({
    final String? message,
    final String? sender,
    final String? receiver,
    final String? room,
  });
}

class _MessageDtoCopyWithProxyImpl implements _MessageDtoCopyWithProxy {
  _MessageDtoCopyWithProxyImpl(this._value);

  final MessageDto _value;

  @pragma('vm:prefer-inline')
  @override
  MessageDto message(String newValue) => this(message: newValue);

  @pragma('vm:prefer-inline')
  @override
  MessageDto sender(String newValue) => this(sender: newValue);

  @pragma('vm:prefer-inline')
  @override
  MessageDto receiver(String newValue) => this(receiver: newValue);

  @pragma('vm:prefer-inline')
  @override
  MessageDto room(String? newValue) => this(room: newValue);

  @pragma('vm:prefer-inline')
  @override
  MessageDto call({
    final String? message,
    final String? sender,
    final String? receiver,
    final Object? room = const Object(),
  }) {
    return _$MessageDtoImpl(
      message: message ?? _value.message,
      sender: sender ?? _value.sender,
      receiver: receiver ?? _value.receiver,
      room: identical(room, const Object()) ? _value.room : (room as String?),
    );
  }
}

sealed class $MessageDtoCopyWithProxyChain<$Result> {
  factory $MessageDtoCopyWithProxyChain(final MessageDto value,
          final $Result Function(MessageDto update) chain) =
      _MessageDtoCopyWithProxyChainImpl<$Result>;

  $Result message(String newValue);

  $Result sender(String newValue);

  $Result receiver(String newValue);

  $Result room(String? newValue);

  $Result call({
    final String? message,
    final String? sender,
    final String? receiver,
    final String? room,
  });
}

class _MessageDtoCopyWithProxyChainImpl<$Result>
    implements $MessageDtoCopyWithProxyChain<$Result> {
  _MessageDtoCopyWithProxyChainImpl(this._value, this._chain);

  final MessageDto _value;
  final $Result Function(MessageDto update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result message(String newValue) => this(message: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result sender(String newValue) => this(sender: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result receiver(String newValue) => this(receiver: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result room(String? newValue) => this(room: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? message,
    final String? sender,
    final String? receiver,
    final Object? room = const Object(),
  }) {
    return _chain(_$MessageDtoImpl(
      message: message ?? _value.message,
      sender: sender ?? _value.sender,
      receiver: receiver ?? _value.receiver,
      room: identical(room, const Object()) ? _value.room : (room as String?),
    ));
  }
}

extension $MessageDtoExtension on MessageDto {
  _MessageDtoCopyWithProxy get copyWith => _MessageDtoCopyWithProxyImpl(this);
}
