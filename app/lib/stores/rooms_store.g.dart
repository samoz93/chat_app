// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoomsStore on _RoomsStore, Store {
  late final _$roomsAtom = Atom(name: '_RoomsStore.rooms', context: context);

  @override
  Map<String, List<User>> get rooms {
    _$roomsAtom.reportRead();
    return super.rooms;
  }

  @override
  set rooms(Map<String, List<User>> value) {
    _$roomsAtom.reportWrite(value, super.rooms, () {
      super.rooms = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: '_RoomsStore.messages', context: context);

  @override
  Map<String, List<Message>> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(Map<String, List<Message>> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$_RoomsStoreActionController =
      ActionController(name: '_RoomsStore', context: context);

  @override
  void updateRoom(String room, List<User> users) {
    final _$actionInfo = _$_RoomsStoreActionController.startAction(
        name: '_RoomsStore.updateRoom');
    try {
      return super.updateRoom(room, users);
    } finally {
      _$_RoomsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void appendMessage(String room, Message message) {
    final _$actionInfo = _$_RoomsStoreActionController.startAction(
        name: '_RoomsStore.appendMessage');
    try {
      return super.appendMessage(room, message);
    } finally {
      _$_RoomsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void leaveRoom(String room) {
    final _$actionInfo = _$_RoomsStoreActionController.startAction(
        name: '_RoomsStore.leaveRoom');
    try {
      return super.leaveRoom(room);
    } finally {
      _$_RoomsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void joinRoom(String room) {
    final _$actionInfo =
        _$_RoomsStoreActionController.startAction(name: '_RoomsStore.joinRoom');
    try {
      return super.joinRoom(room);
    } finally {
      _$_RoomsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendMessage(String message, String room) {
    final _$actionInfo = _$_RoomsStoreActionController.startAction(
        name: '_RoomsStore.sendMessage');
    try {
      return super.sendMessage(message, room);
    } finally {
      _$_RoomsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
rooms: ${rooms},
messages: ${messages}
    ''';
  }
}
