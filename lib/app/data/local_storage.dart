import 'package:hive/hive.dart';

class LocalStorage {
  final box = Hive.box('local');

  String key = 'key';

  setKey(String keyVal) {
    box.put(key, keyVal);
  }

  String getKey() {
    return box.get(key);
  }
}
