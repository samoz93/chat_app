// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_chat.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseChat<T extends Message> on BaseChatBase<T>, Store {
  Computed<int>? _$totalPagesComputed;

  @override
  int get totalPages =>
      (_$totalPagesComputed ??= Computed<int>(() => super.totalPages,
              name: 'BaseChatBase.totalPages'))
          .value;
  Computed<List<T>>? _$messageChunckComputed;

  @override
  List<T> get messageChunck =>
      (_$messageChunckComputed ??= Computed<List<T>>(() => super.messageChunck,
              name: 'BaseChatBase.messageChunck'))
          .value;
  Computed<List<(String, List<T>)>>? _$messageGroupsComputed;

  @override
  List<(String, List<T>)> get messageGroups => (_$messageGroupsComputed ??=
          Computed<List<(String, List<T>)>>(() => super.messageGroups,
              name: 'BaseChatBase.messageGroups'))
      .value;

  late final _$messagesAtom =
      Atom(name: 'BaseChatBase.messages', context: context);

  @override
  List<T> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<T> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$_pageAtom = Atom(name: 'BaseChatBase._page', context: context);

  @override
  int get _page {
    _$_pageAtom.reportRead();
    return super._page;
  }

  @override
  set _page(int value) {
    _$_pageAtom.reportWrite(value, super._page, () {
      super._page = value;
    });
  }

  late final _$usersAtom = Atom(name: 'BaseChatBase.users', context: context);

  @override
  List<User> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<User> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$BaseChatBaseActionController =
      ActionController(name: 'BaseChatBase', context: context);

  @override
  void updateUsers(List<User> users) {
    final _$actionInfo = _$BaseChatBaseActionController.startAction(
        name: 'BaseChatBase.updateUsers');
    try {
      return super.updateUsers(users);
    } finally {
      _$BaseChatBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadMoreMessages() {
    final _$actionInfo = _$BaseChatBaseActionController.startAction(
        name: 'BaseChatBase.loadMoreMessages');
    try {
      return super.loadMoreMessages();
    } finally {
      _$BaseChatBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void appendMessage(T message) {
    final _$actionInfo = _$BaseChatBaseActionController.startAction(
        name: 'BaseChatBase.appendMessage');
    try {
      return super.appendMessage(message);
    } finally {
      _$BaseChatBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messages: ${messages},
users: ${users},
totalPages: ${totalPages},
messageChunck: ${messageChunck},
messageGroups: ${messageGroups}
    ''';
  }
}
