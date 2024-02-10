// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoomsStore on RoomsStoreBase, Store {
  late final _$RoomsStoreBaseActionController =
      ActionController(name: 'RoomsStoreBase', context: context);

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

    ''';
  }
}
