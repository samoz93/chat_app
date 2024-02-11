// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'private_chat_dto.dart';

class _$PrivateChatDtoImpl extends PrivateChatDto {
  _$PrivateChatDtoImpl({
    required this.peer,
    required List<PrivateMessageDto> oldMessages,
  })  : _oldMessages = oldMessages,
        super.ctor();

  @override
  final User peer;

  @override
  List<PrivateMessageDto> get oldMessages =>
      List<PrivateMessageDto>.unmodifiable(_oldMessages);
  final List<PrivateMessageDto> _oldMessages;

  factory _$PrivateChatDtoImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$PrivateChatDtoImpl(
      peer: User.fromJson(json['peer']),
      oldMessages: <PrivateMessageDto>[
        for (final dynamic i0 in (json['oldMessages'] as List<dynamic>))
          PrivateMessageDto.fromJson(i0),
      ],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'peer': peer.toJson(),
      'oldMessages': <dynamic>[
        for (final PrivateMessageDto i0 in oldMessages) i0.toJson(),
      ],
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is PrivateChatDto &&
            runtimeType == other.runtimeType &&
            peer == other.peer &&
            deepEquality(oldMessages, other.oldMessages);
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      peer,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'PrivateChatDto{<optimized out>}';
    assert(() {
      toStringOutput =
          'PrivateChatDto@<$hexIdentity>{peer: $peer, oldMessages: $oldMessages}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => PrivateChatDto;
}

abstract interface class _PrivateChatDtoCopyWithProxy {
  $UserCopyWithProxyChain<PrivateChatDto> get peer;

  PrivateChatDto oldMessages(List<PrivateMessageDto> newValue);

  PrivateChatDto call({
    final User? peer,
    final List<PrivateMessageDto>? oldMessages,
  });
}

class _PrivateChatDtoCopyWithProxyImpl implements _PrivateChatDtoCopyWithProxy {
  _PrivateChatDtoCopyWithProxyImpl(this._value);

  final PrivateChatDto _value;

  @pragma('vm:prefer-inline')
  @override
  $UserCopyWithProxyChain<PrivateChatDto> get peer =>
      $UserCopyWithProxyChain<PrivateChatDto>(
          _value.peer, (User update) => this(peer: update));

  @pragma('vm:prefer-inline')
  @override
  PrivateChatDto oldMessages(List<PrivateMessageDto> newValue) =>
      this(oldMessages: newValue);

  @pragma('vm:prefer-inline')
  @override
  PrivateChatDto call({
    final User? peer,
    final List<PrivateMessageDto>? oldMessages,
  }) {
    return _$PrivateChatDtoImpl(
      peer: peer ?? _value.peer,
      oldMessages: oldMessages ?? _value.oldMessages,
    );
  }
}

sealed class $PrivateChatDtoCopyWithProxyChain<$Result> {
  factory $PrivateChatDtoCopyWithProxyChain(final PrivateChatDto value,
          final $Result Function(PrivateChatDto update) chain) =
      _PrivateChatDtoCopyWithProxyChainImpl<$Result>;

  $Result peer(User newValue);

  $Result oldMessages(List<PrivateMessageDto> newValue);

  $Result call({
    final User? peer,
    final List<PrivateMessageDto>? oldMessages,
  });
}

class _PrivateChatDtoCopyWithProxyChainImpl<$Result>
    implements $PrivateChatDtoCopyWithProxyChain<$Result> {
  _PrivateChatDtoCopyWithProxyChainImpl(this._value, this._chain);

  final PrivateChatDto _value;
  final $Result Function(PrivateChatDto update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result peer(User newValue) => this(peer: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result oldMessages(List<PrivateMessageDto> newValue) =>
      this(oldMessages: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final User? peer,
    final List<PrivateMessageDto>? oldMessages,
  }) {
    return _chain(_$PrivateChatDtoImpl(
      peer: peer ?? _value.peer,
      oldMessages: oldMessages ?? _value.oldMessages,
    ));
  }
}

extension $PrivateChatDtoExtension on PrivateChatDto {
  _PrivateChatDtoCopyWithProxy get copyWith =>
      _PrivateChatDtoCopyWithProxyImpl(this);
}
