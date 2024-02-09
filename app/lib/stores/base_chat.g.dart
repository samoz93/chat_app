// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_chat.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseChat on BaseChatBase, Store {
  Computed<int>? _$totalPagesComputed;

  @override
  int get totalPages =>
      (_$totalPagesComputed ??= Computed<int>(() => super.totalPages,
              name: 'BaseChatBase.totalPages'))
          .value;
  Computed<List<Message>>? _$messageChunckComputed;

  @override
  List<Message> get messageChunck => (_$messageChunckComputed ??=
          Computed<List<Message>>(() => super.messageChunck,
              name: 'BaseChatBase.messageChunck'))
      .value;
  Computed<List<(String, List<Message>)>>? _$messageGroupsComputed;

  @override
  List<(String, List<Message>)> get messageGroups =>
      (_$messageGroupsComputed ??= Computed<List<(String, List<Message>)>>(
              () => super.messageGroups,
              name: 'BaseChatBase.messageGroups'))
          .value;

  late final _$messagesAtom =
      Atom(name: 'BaseChatBase.messages', context: context);

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

  late final _$BaseChatBaseActionController =
      ActionController(name: 'BaseChatBase', context: context);

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
  void appendMessage(Message message) {
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
totalPages: ${totalPages},
messageChunck: ${messageChunck},
messageGroups: ${messageGroups}
    ''';
  }
}