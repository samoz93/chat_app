// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'user_dto.dart';

class _$UserImpl extends User {
  _$UserImpl({
    required this.id,
    required this.email,
    required this.name,
  }) : super.ctor();

  @override
  final String id;

  @override
  final String email;

  @override
  final String name;

  factory _$UserImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
    };
  }

  @override
  bool operator ==(Object? other) {
    return identical(this, other) ||
        other is User &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            email == other.email &&
            name == other.name;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      id,
      email,
      name,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'User{<optimized out>}';
    assert(() {
      toStringOutput =
          'User@<$hexIdentity>{id: $id, email: $email, name: $name}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => User;
}

abstract interface class _UserCopyWithProxy {
  User id(String newValue);

  User email(String newValue);

  User name(String newValue);

  User call({
    final String? id,
    final String? email,
    final String? name,
  });
}

class _UserCopyWithProxyImpl implements _UserCopyWithProxy {
  _UserCopyWithProxyImpl(this._value);

  final User _value;

  @pragma('vm:prefer-inline')
  @override
  User id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  @override
  User email(String newValue) => this(email: newValue);

  @pragma('vm:prefer-inline')
  @override
  User name(String newValue) => this(name: newValue);

  @pragma('vm:prefer-inline')
  @override
  User call({
    final String? id,
    final String? email,
    final String? name,
  }) {
    return _$UserImpl(
      id: id ?? _value.id,
      email: email ?? _value.email,
      name: name ?? _value.name,
    );
  }
}

sealed class $UserCopyWithProxyChain<$Result> {
  factory $UserCopyWithProxyChain(
          final User value, final $Result Function(User update) chain) =
      _UserCopyWithProxyChainImpl<$Result>;

  $Result id(String newValue);

  $Result email(String newValue);

  $Result name(String newValue);

  $Result call({
    final String? id,
    final String? email,
    final String? name,
  });
}

class _UserCopyWithProxyChainImpl<$Result>
    implements $UserCopyWithProxyChain<$Result> {
  _UserCopyWithProxyChainImpl(this._value, this._chain);

  final User _value;
  final $Result Function(User update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result email(String newValue) => this(email: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result name(String newValue) => this(name: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? id,
    final String? email,
    final String? name,
  }) {
    return _chain(_$UserImpl(
      id: id ?? _value.id,
      email: email ?? _value.email,
      name: name ?? _value.name,
    ));
  }
}

extension $UserExtension on User {
  _UserCopyWithProxy get copyWith => _UserCopyWithProxyImpl(this);
}
