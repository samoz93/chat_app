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

  late final _$_RoomsStoreActionController =
      ActionController(name: '_RoomsStore', context: context);

  @override
  void joinRoom(String room, User user) {
    final _$actionInfo =
        _$_RoomsStoreActionController.startAction(name: '_RoomsStore.joinRoom');
    try {
      return super.joinRoom(room, user);
    } finally {
      _$_RoomsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void leaveRoom(String room, User user) {
    final _$actionInfo = _$_RoomsStoreActionController.startAction(
        name: '_RoomsStore.leaveRoom');
    try {
      return super.leaveRoom(room, user);
    } finally {
      _$_RoomsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
rooms: ${rooms}
    ''';
  }
}
