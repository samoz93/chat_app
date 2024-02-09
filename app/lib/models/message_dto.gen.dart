// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'message_dto.dart';

class _$MessageDtoImpl extends MessageDto {
  _$MessageDtoImpl({
    required this.message,
    this.room,
    required this.sender,
    required this.receiver,
    required this.createdAt,
  }) : super.ctor();

  @override
  final String message;

  @override
  final String? room;

  @override
  final User sender;

  @override
  final String receiver;

  @override
  final int createdAt;

  factory _$MessageDtoImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$MessageDtoImpl(
      message: json['message'] as String,
      room: json['room'] as String?,
      sender: User.fromJson(json['sender']),
      receiver: json['receiver'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'room': room,
      'sender': sender.toJson(),
      'receiver': receiver,
      'createdAt': createdAt,
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is MessageDto &&
            runtimeType == other.runtimeType &&
            message == other.message &&
            room == other.room &&
            sender == other.sender &&
            receiver == other.receiver &&
            createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      message,
      room,
      sender,
      receiver,
      createdAt,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'MessageDto{<optimized out>}';
    assert(() {
      toStringOutput =
          'MessageDto@<$hexIdentity>{message: $message, room: $room, sender: $sender, receiver: $receiver, createdAt: $createdAt}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => MessageDto;
}

abstract interface class _MessageDtoCopyWithProxy {
  MessageDto message(String newValue);

  MessageDto room(String? newValue);

  $UserCopyWithProxyChain<MessageDto> get sender;

  MessageDto receiver(String newValue);

  MessageDto createdAt(int newValue);

  MessageDto call({
    final String? message,
    final String? room,
    final User? sender,
    final String? receiver,
    final int? createdAt,
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
  MessageDto room(String? newValue) => this(room: newValue);

  @pragma('vm:prefer-inline')
  @override
  $UserCopyWithProxyChain<MessageDto> get sender =>
      $UserCopyWithProxyChain<MessageDto>(
          _value.sender, (User update) => this(sender: update));

  @pragma('vm:prefer-inline')
  @override
  MessageDto receiver(String newValue) => this(receiver: newValue);

  @pragma('vm:prefer-inline')
  @override
  MessageDto createdAt(int newValue) => this(createdAt: newValue);

  @pragma('vm:prefer-inline')
  @override
  MessageDto call({
    final String? message,
    final Object? room = const Object(),
    final User? sender,
    final String? receiver,
    final int? createdAt,
  }) {
    return _$MessageDtoImpl(
      message: message ?? _value.message,
      room: identical(room, const Object()) ? _value.room : (room as String?),
      sender: sender ?? _value.sender,
      receiver: receiver ?? _value.receiver,
      createdAt: createdAt ?? _value.createdAt,
    );
  }
}

sealed class $MessageDtoCopyWithProxyChain<$Result> {
  factory $MessageDtoCopyWithProxyChain(final MessageDto value,
          final $Result Function(MessageDto update) chain) =
      _MessageDtoCopyWithProxyChainImpl<$Result>;

  $Result message(String newValue);

  $Result room(String? newValue);

  $Result sender(User newValue);

  $Result receiver(String newValue);

  $Result createdAt(int newValue);

  $Result call({
    final String? message,
    final String? room,
    final User? sender,
    final String? receiver,
    final int? createdAt,
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
  $Result room(String? newValue) => this(room: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result sender(User newValue) => this(sender: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result receiver(String newValue) => this(receiver: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result createdAt(int newValue) => this(createdAt: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? message,
    final Object? room = const Object(),
    final User? sender,
    final String? receiver,
    final int? createdAt,
  }) {
    return _chain(_$MessageDtoImpl(
      message: message ?? _value.message,
      room: identical(room, const Object()) ? _value.room : (room as String?),
      sender: sender ?? _value.sender,
      receiver: receiver ?? _value.receiver,
      createdAt: createdAt ?? _value.createdAt,
    ));
  }
}

extension $MessageDtoExtension on MessageDto {
  _MessageDtoCopyWithProxy get copyWith => _MessageDtoCopyWithProxyImpl(this);
}
