import 'package:hive/hive.dart';

class BoxLocal<T> {
  final String boxName;
  Box<T>? _box; // Cache the box

  BoxLocal(this.boxName);

  // Initialize the box only once
  Future<void> _initializeBox() async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox<T>(boxName);
    }
  }

  // Get a value
  Future<T?> getValue() async {
    await _initializeBox();
    return _box?.get(boxName);
  }

  // Save a value
  Future<void> setValue(T value) async {
    await _initializeBox();
    await _box?.put(boxName, value);
  }

  // Clear a value
  Future<void> clearValue() async {
    await _initializeBox();
    await _box?.delete(boxName);
  }

  // Optional: Close the box when it's no longer needed
  Future<void> closeBox() async {
    await _box?.close();
    _box = null;
  }
}

abstract class BaseLocal<T> {
  Future<T?> getData();
  Future<void> setData(T data);
  Future<void> clearData();
}
