// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoomsStore on RoomsStoreBase, Store {
  Computed<int>? _$totalPagesComputed;

  @override
  int get totalPages =>
      (_$totalPagesComputed ??= Computed<int>(() => super.totalPages,
              name: 'RoomsStoreBase.totalPages'))
          .value;
  Computed<List<Message>>? _$messageChunckComputed;

  @override
  List<Message> get messageChunck => (_$messageChunckComputed ??=
          Computed<List<Message>>(() => super.messageChunck,
              name: 'RoomsStoreBase.messageChunck'))
      .value;
  Computed<List<(String, List<Message>)>>? _$messageGroupsComputed;

  @override
  List<(String, List<Message>)> get messageGroups =>
      (_$messageGroupsComputed ??= Computed<List<(String, List<Message>)>>(
              () => super.messageGroups,
              name: 'RoomsStoreBase.messageGroups'))
          .value;

  late final _$usersAtom = Atom(name: 'RoomsStoreBase.users', context: context);

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

  late final _$messagesAtom =
      Atom(name: 'RoomsStoreBase.messages', context: context);

  @override
  List<Message> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<Message> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$_pageAtom = Atom(name: 'RoomsStoreBase._page', context: context);

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

  late final _$RoomsStoreBaseActionController =
      ActionController(name: 'RoomsStoreBase', context: context);

  @override
  void loadMoreMessages() {
    final _$actionInfo = _$RoomsStoreBaseActionController.startAction(
        name: 'RoomsStoreBase.loadMoreMessages');
    try {
      return super.loadMoreMessages();
    } finally {
      _$RoomsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateRoom(List<User> users) {
    final _$actionInfo = _$RoomsStoreBaseActionController.startAction(
        name: 'RoomsStoreBase.updateRoom');
    try {
      return super.updateRoom(users);
    } finally {
      _$RoomsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void appendMessage(Message message) {
    final _$actionInfo = _$RoomsStoreBaseActionController.startAction(
        name: 'RoomsStoreBase.appendMessage');
    try {
      return super.appendMessage(message);
    } finally {
      _$RoomsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void leaveRoom() {
    final _$actionInfo = _$RoomsStoreBaseActionController.startAction(
        name: 'RoomsStoreBase.leaveRoom');
    try {
      return super.leaveRoom();
    } finally {
      _$RoomsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void joinRoom() {
    final _$actionInfo = _$RoomsStoreBaseActionController.startAction(
        name: 'RoomsStoreBase.joinRoom');
    try {
      return super.joinRoom();
    } finally {
      _$RoomsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendMessage(String message) {
    final _$actionInfo = _$RoomsStoreBaseActionController.startAction(
        name: 'RoomsStoreBase.sendMessage');
    try {
      return super.sendMessage(message);
    } finally {
      _$RoomsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
users: ${users},
messages: ${messages},
totalPages: ${totalPages},
messageChunck: ${messageChunck},
messageGroups: ${messageGroups}
    ''';
  }
}
