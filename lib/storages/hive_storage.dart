import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'storage.dart';

const kHiveStorageKey = 'hive-storage-key';

@singleton
class HiveStorage extends KeyStorage {
  final Box box;
  HiveStorage() : box = Hive.box(KeyStorage.setting);

  String get token => box.get(KeyStorage.accessToken, defaultValue: '');
  void updateToken(String value) => box.put(KeyStorage.accessToken, value);
  void clearToken() => box.delete(KeyStorage.accessToken);

  Future<void> clearAll() async => await box.deleteAll([
        KeyStorage.accessToken,
      ]);
}
