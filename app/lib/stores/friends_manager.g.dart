// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendsManager on FriendsManagerBase, Store {
  Computed<Map<String, PrivateChatStore>>? _$storesComputed;

  @override
  Map<String, PrivateChatStore> get stores => (_$storesComputed ??=
          Computed<Map<String, PrivateChatStore>>(() => super.stores,
              name: 'FriendsManagerBase.stores'))
      .value;

  late final _$friendsAtom =
      Atom(name: 'FriendsManagerBase.friends', context: context);

  @override
  Set<User> get friends {
    _$friendsAtom.reportRead();
    return super.friends;
  }

  @override
  set friends(Set<User> value) {
    _$friendsAtom.reportWrite(value, super.friends, () {
      super.friends = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('FriendsManagerBase.initState', context: context);

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  @override
  String toString() {
    return '''
friends: ${friends},
stores: ${stores}
    ''';
  }
}
