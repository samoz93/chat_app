// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'auth_payload.dart';

class _$AuthPayloadImpl extends AuthPayload {
  _$AuthPayloadImpl({
    required this.token,
    required this.user,
  }) : super.ctor();

  @override
  final String token;

  @override
  final User user;

  factory _$AuthPayloadImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$AuthPayloadImpl(
      token: json['token'] as String,
      user: User.fromJson(json['user']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
      'user': user.toJson(),
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is AuthPayload &&
            runtimeType == other.runtimeType &&
            token == other.token &&
            user == other.user;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      token,
      user,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'AuthPayload{<optimized out>}';
    assert(() {
      toStringOutput = 'AuthPayload@<$hexIdentity>{token: $token, user: $user}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => AuthPayload;
}

abstract interface class _AuthPayloadCopyWithProxy {
  AuthPayload token(String newValue);

  $UserCopyWithProxyChain<AuthPayload> get user;

  AuthPayload call({
    final String? token,
    final User? user,
  });
}

class _AuthPayloadCopyWithProxyImpl implements _AuthPayloadCopyWithProxy {
  _AuthPayloadCopyWithProxyImpl(this._value);

  final AuthPayload _value;

  @pragma('vm:prefer-inline')
  @override
  AuthPayload token(String newValue) => this(token: newValue);

  @pragma('vm:prefer-inline')
  @override
  $UserCopyWithProxyChain<AuthPayload> get user =>
      $UserCopyWithProxyChain<AuthPayload>(
          _value.user, (User update) => this(user: update));

  @pragma('vm:prefer-inline')
  @override
  AuthPayload call({
    final String? token,
    final User? user,
  }) {
    return _$AuthPayloadImpl(
      token: token ?? _value.token,
      user: user ?? _value.user,
    );
  }
}

sealed class $AuthPayloadCopyWithProxyChain<$Result> {
  factory $AuthPayloadCopyWithProxyChain(final AuthPayload value,
          final $Result Function(AuthPayload update) chain) =
      _AuthPayloadCopyWithProxyChainImpl<$Result>;

  $Result token(String newValue);

  $Result user(User newValue);

  $Result call({
    final String? token,
    final User? user,
  });
}

class _AuthPayloadCopyWithProxyChainImpl<$Result>
    implements $AuthPayloadCopyWithProxyChain<$Result> {
  _AuthPayloadCopyWithProxyChainImpl(this._value, this._chain);

  final AuthPayload _value;
  final $Result Function(AuthPayload update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result token(String newValue) => this(token: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result user(User newValue) => this(user: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? token,
    final User? user,
  }) {
    return _chain(_$AuthPayloadImpl(
      token: token ?? _value.token,
      user: user ?? _value.user,
    ));
  }
}

extension $AuthPayloadExtension on AuthPayload {
  _AuthPayloadCopyWithProxy get copyWith => _AuthPayloadCopyWithProxyImpl(this);
}
