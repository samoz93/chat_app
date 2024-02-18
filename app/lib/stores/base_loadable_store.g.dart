// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_loadable_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseLoadableStore on BaseLoadableStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: 'BaseLoadableStoreBase.loading', context: context);

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

  late final _$errorAtom =
      Atom(name: 'BaseLoadableStoreBase.error', context: context);

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

  late final _$searchAtom =
      Atom(name: 'BaseLoadableStoreBase.search', context: context);

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  late final _$BaseLoadableStoreBaseActionController =
      ActionController(name: 'BaseLoadableStoreBase', context: context);

  @override
  void setSearch(String value) {
    final _$actionInfo = _$BaseLoadableStoreBaseActionController.startAction(
        name: 'BaseLoadableStoreBase.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$BaseLoadableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$BaseLoadableStoreBaseActionController.startAction(
        name: 'BaseLoadableStoreBase.clearError');
    try {
      return super.clearError();
    } finally {
      _$BaseLoadableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearSearch() {
    final _$actionInfo = _$BaseLoadableStoreBaseActionController.startAction(
        name: 'BaseLoadableStoreBase.clearSearch');
    try {
      return super.clearSearch();
    } finally {
      _$BaseLoadableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$BaseLoadableStoreBaseActionController.startAction(
        name: 'BaseLoadableStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$BaseLoadableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(dynamic value) {
    final _$actionInfo = _$BaseLoadableStoreBaseActionController.startAction(
        name: 'BaseLoadableStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$BaseLoadableStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
error: ${error},
search: ${search}
    ''';
  }
}
