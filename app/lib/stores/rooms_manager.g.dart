// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoomsManager on RoomsManagerBase, Store {
  Computed<List<RoomDto>>? _$roomsComputed;

  @override
  List<RoomDto> get rooms =>
      (_$roomsComputed ??= Computed<List<RoomDto>>(() => super.rooms,
              name: 'RoomsManagerBase.rooms'))
          .value;

  late final _$_roomsAtom =
      Atom(name: 'RoomsManagerBase._rooms', context: context);

  @override
  List<RoomDto> get _rooms {
    _$_roomsAtom.reportRead();
    return super._rooms;
  }

  @override
  set _rooms(List<RoomDto> value) {
    _$_roomsAtom.reportWrite(value, super._rooms, () {
      super._rooms = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('RoomsManagerBase.initState', context: context);

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  @override
  String toString() {
    return '''
rooms: ${rooms}
    ''';
  }
}
