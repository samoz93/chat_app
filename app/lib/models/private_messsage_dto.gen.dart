// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'private_messsage_dto.dart';

class _$PrivateMessageDtoImpl extends PrivateMessageDto {
  _$PrivateMessageDtoImpl({
    required this.message,
    required this.sender,
    required this.receiver,
    required this.createdAt,
  }) : super.ctor();

  @override
  final String message;

  @override
  final User sender;

  @override
  final String receiver;

  @override
  final int createdAt;

  factory _$PrivateMessageDtoImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$PrivateMessageDtoImpl(
      message: json['message'] as String,
      sender: User.fromJson(json['sender']),
      receiver: json['receiver'] as String,
      createdAt: (json['createdAt'] as num).toInt(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'sender': sender.toJson(),
      'receiver': receiver,
      'createdAt': createdAt,
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is PrivateMessageDto &&
            runtimeType == other.runtimeType &&
            message == other.message &&
            sender == other.sender &&
            receiver == other.receiver &&
            createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      message,
      sender,
      receiver,
      createdAt,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'PrivateMessageDto{<optimized out>}';
    assert(() {
      toStringOutput =
          'PrivateMessageDto@<$hexIdentity>{message: $message, sender: $sender, receiver: $receiver, createdAt: $createdAt}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => PrivateMessageDto;
}

abstract interface class _PrivateMessageDtoCopyWithProxy {
  PrivateMessageDto message(String newValue);

  $UserCopyWithProxyChain<PrivateMessageDto> get sender;

  PrivateMessageDto receiver(String newValue);

  PrivateMessageDto createdAt(int newValue);

  PrivateMessageDto call({
    final String? message,
    final User? sender,
    final String? receiver,
    final int? createdAt,
  });
}

class _PrivateMessageDtoCopyWithProxyImpl
    implements _PrivateMessageDtoCopyWithProxy {
  _PrivateMessageDtoCopyWithProxyImpl(this._value);

  final PrivateMessageDto _value;

  @pragma('vm:prefer-inline')
  @override
  PrivateMessageDto message(String newValue) => this(message: newValue);

  @pragma('vm:prefer-inline')
  @override
  $UserCopyWithProxyChain<PrivateMessageDto> get sender =>
      $UserCopyWithProxyChain<PrivateMessageDto>(
          _value.sender, (User update) => this(sender: update));

  @pragma('vm:prefer-inline')
  @override
  PrivateMessageDto receiver(String newValue) => this(receiver: newValue);

  @pragma('vm:prefer-inline')
  @override
  PrivateMessageDto createdAt(int newValue) => this(createdAt: newValue);

  @pragma('vm:prefer-inline')
  @override
  PrivateMessageDto call({
    final String? message,
    final User? sender,
    final String? receiver,
    final int? createdAt,
  }) {
    return _$PrivateMessageDtoImpl(
      message: message ?? _value.message,
      sender: sender ?? _value.sender,
      receiver: receiver ?? _value.receiver,
      createdAt: createdAt ?? _value.createdAt,
    );
  }
}

sealed class $PrivateMessageDtoCopyWithProxyChain<$Result> {
  factory $PrivateMessageDtoCopyWithProxyChain(final PrivateMessageDto value,
          final $Result Function(PrivateMessageDto update) chain) =
      _PrivateMessageDtoCopyWithProxyChainImpl<$Result>;

  $Result message(String newValue);

  $Result sender(User newValue);

  $Result receiver(String newValue);

  $Result createdAt(int newValue);

  $Result call({
    final String? message,
    final User? sender,
    final String? receiver,
    final int? createdAt,
  });
}

class _PrivateMessageDtoCopyWithProxyChainImpl<$Result>
    implements $PrivateMessageDtoCopyWithProxyChain<$Result> {
  _PrivateMessageDtoCopyWithProxyChainImpl(this._value, this._chain);

  final PrivateMessageDto _value;
  final $Result Function(PrivateMessageDto update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result message(String newValue) => this(message: newValue);

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
    final User? sender,
    final String? receiver,
    final int? createdAt,
  }) {
    return _chain(_$PrivateMessageDtoImpl(
      message: message ?? _value.message,
      sender: sender ?? _value.sender,
      receiver: receiver ?? _value.receiver,
      createdAt: createdAt ?? _value.createdAt,
    ));
  }
}

extension $PrivateMessageDtoExtension on PrivateMessageDto {
  _PrivateMessageDtoCopyWithProxy get copyWith =>
      _PrivateMessageDtoCopyWithProxyImpl(this);
}
