// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??=
          Computed<bool>(() => super.isLoggedIn, name: '_AuthStore.isLoggedIn'))
      .value;

  late final _$meAtom = Atom(name: '_AuthStore.me', context: context);

  @override
  User? get me {
    _$meAtom.reportRead();
    return super.me;
  }

  @override
  set me(User? value) {
    _$meAtom.reportWrite(value, super.me, () {
      super.me = value;
    });
  }

  late final _$errorAtom = Atom(name: '_AuthStore.error', context: context);

  @override
  dynamic get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(dynamic value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$loadingAtom = Atom(name: '_AuthStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$tokenAtom = Atom(name: '_AuthStore.token', context: context);

  @override
  String? get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String? value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStore.login', context: context);

  @override
  Future<(dynamic, AuthPayload?)> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$signupAsyncAction =
      AsyncAction('_AuthStore.signup', context: context);

  @override
  Future signup(
      {required String email, required String password, required String name}) {
    return _$signupAsyncAction
        .run(() => super.signup(email: email, password: password, name: name));
  }

  late final _$signoutAsyncAction =
      AsyncAction('_AuthStore.signout', context: context);

  @override
  Future signout() {
    return _$signoutAsyncAction.run(() => super.signout());
  }

  @override
  String toString() {
    return '''
me: ${me},
error: ${error},
loading: ${loading},
token: ${token},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
