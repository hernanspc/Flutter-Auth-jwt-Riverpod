import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final perfs = await getSharedPrefs();

    switch (T) {
      case int:
        return perfs.getInt(key) as T?;
      case String:
        return perfs.getString(key) as T?;
      default:
        throw UnimplementedError(
            'GET not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final perfs = await getSharedPrefs();
    return await perfs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final perfs = await getSharedPrefs();

    switch (T) {
      case int:
        perfs.setInt(key, value as int);
        break;
      case String:
        perfs.setString(key, value as String);
        break;
      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}
