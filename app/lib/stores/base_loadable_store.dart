import 'package:app/utils/await_to_dart.dart';
import 'package:mobx/mobx.dart';

part 'base_loadable_store.g.dart';

abstract class BaseLoadableStore extends BaseLoadableStoreBase
    with _$BaseLoadableStore {}

abstract class BaseLoadableStoreBase with Store {
  @observable
  bool loading = false;

  // TODO: Add error type
  @observable
  dynamic error;

  @observable
  String search = '';

  @action
  void setSearch(String value) {
    search = value;
  }

  @action
  void clearError() {
    error = null;
  }

  @action
  clearSearch() {
    search = '';
  }

  @action
  void setLoading(bool value) {
    loading = value;
  }

  Future<T?> getData<T>(Future<T> fn) async {
    setLoading(true);
    final (err, data) = await to(fn);
    if (err != null) {
      setError(err);
      return null;
    }
    setLoading(false);
    return data;
  }

  @action
  void setError(dynamic value) {
    error = value;
    loading = false;
  }
}
