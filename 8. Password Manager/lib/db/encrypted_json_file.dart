import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'dart:io';

import 'common.dart';
import 'json_convertable.dart';
import 'saveable_file_base.dart';

class EncryptedJsonFile<T extends JsonConvertable> with SaveableFileBase {
  final T value;
  final File _file;
  Encrypter _encrypter;
  set encrypter(Encrypter encrypter) => _encrypter = encrypter;

  EncryptedJsonFile(
    this._file, {
    required Encrypter encrypter,
    required this.value,
  }) : _encrypter = encrypter;

  factory EncryptedJsonFile.fromFile(
    File file, {
    required Encrypter encrypter,
    required T Function() constructor,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    if (file.existsSync()) {
      return EncryptedJsonFile<T>(
        file,
        encrypter: encrypter,
        value: fromJson(
            jsonDecode(decrypt(file.readAsStringSync(), encrypter: encrypter))),
      );
    }
    file.createSync(recursive: true);
    // ignore: no_leading_underscores_for_local_identifiers
    EncryptedJsonFile<T> _file =
        EncryptedJsonFile<T>(file, encrypter: encrypter, value: constructor());
    _file.saveSync();
    return _file;
  }

  @override
  Future<void> save() =>
      _file.writeAsString(encrypt(jsonEncode(value), encrypter: _encrypter));
  @override
  void saveSync() => _file
      .writeAsStringSync(encrypt(jsonEncode(value), encrypter: _encrypter));
}
