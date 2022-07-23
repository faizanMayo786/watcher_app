import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(
      _loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark,
    );
    _saveThemeToBox(!_loadThemeFromBox());
  }
}

