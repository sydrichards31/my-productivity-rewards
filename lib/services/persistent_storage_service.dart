import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_productive_rewards/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorageService {
  static const String pointsKey = 'points';
  static const String goalPointsKey = 'goalPoints';

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<String> getString(String key, {String defaultValue = ''}) async {
    final value = await _getStringWithSecureStorage(key, defaultValue);
    if (value.isNotEmpty) {
      return value;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final valueFromPrefs = prefs.getString(key);
    if (valueFromPrefs.isNotNullOrEmpty) {
      _setStringWithSecureStorage(key, valueFromPrefs!);
      _removeFromSharedPreferences(key);
    }
    return valueFromPrefs ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    _setStringWithSecureStorage(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    final list = await _getStringListWithSecureStorage(key);
    if (list.isNotNullOrEmpty) return list;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? listFromPrefs = prefs.getStringList(key);
    if (listFromPrefs.isNotNullOrEmpty) {
      _setStringListWithSecureStorage(key, listFromPrefs!);
      _removeFromSharedPreferences(key);
    }
    return listFromPrefs;
  }

  Future<void> setStringList(String key, List<String> list) async {
    _setStringListWithSecureStorage(key, list);
  }

  Future<void> remove(String key) async {
    await _removeFromSecureStorage(key);
    await _removeFromSharedPreferences(key);
  }

  Future<bool> _removeFromSharedPreferences(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<String> _getStringWithSecureStorage(
    String key,
    String defaultValue,
  ) async {
    try {
      final value = await _storage.read(key: key);
      return value ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  Future<void> _setStringWithSecureStorage(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
    );
  }

  Future<List<String>?> _getStringListWithSecureStorage(String key) async {
    try {
      final listAsString = await _storage.read(key: key);
      if (listAsString.isNullOrEmpty) return null;
      // Modified from Shared Preferences implementation
      var list = jsonDecode(listAsString!) as List<dynamic>?;
      if (list != null && list is! List<String>) {
        list = list.cast<String>().toList();
      }
      return list as List<String>?;
    } catch (e) {
      return null;
    }
  }

  Future<void> _setStringListWithSecureStorage(
    String key,
    List<String> list,
  ) async {
    final listAsString = jsonEncode(list);
    await _storage.write(
      key: key,
      value: listAsString,
    );
  }

  Future<void> _removeFromSecureStorage(String key) async {
    await _storage.delete(key: key);
  }
}
