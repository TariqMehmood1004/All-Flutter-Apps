import 'package:flutter/material.dart';
import 'dart:io';

import 'common.dart';
import 'json_convertable.dart';
import 'json_file.dart';

typedef InfoFile = JsonFile<Info>;

const _themeModeToJson = {
  ThemeMode.system: 'system',
  ThemeMode.dark: 'dark',
  ThemeMode.light: 'light',
};

const _themeModeFromJson = {
  'system': ThemeMode.system,
  'dark': ThemeMode.dark,
  'light': ThemeMode.light,
};

class Info with JsonConvertable {
  String version;
  String lastUsername;
  ThemeMode themeMode;

  Info({
    this.version = Version,
    this.lastUsername = '',
    this.themeMode = ThemeMode.dark,
  });

  Info.fromJson(Map<String, dynamic> json)
      : version = json['version'] ?? '0.0.0',
        lastUsername = json['lastUsername'] ?? '',
        themeMode = _themeModeFromJson[json['themeMode']] ?? ThemeMode.dark;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'version': version,
        'lastUsername': lastUsername,
        'themeMode': _themeModeToJson[themeMode],
      };

  static InfoFile fromFile(File file) => InfoFile.fromFile(file,
      constructor: () => Info(), fromJson: Info.fromJson);
}
