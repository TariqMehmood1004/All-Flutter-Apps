// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:app/db/common.dart';
import 'package:app/db/entry.dart';
import 'package:app/db/saveable_file_base.dart';
import 'package:encrypt/encrypt.dart';
import 'dart:io';

import 'entries.dart';

class EntriesEncryptedCSVFile<T extends Entry<T>> with SaveableFileBase {
  final File _file;
  final Entries<T> value;
  Encrypter _encrypter;
  set encrypter(Encrypter encrypter) => _encrypter = encrypter;

  EntriesEncryptedCSVFile(
    this._file, {
    required Encrypter encrypter,
    required this.value,
  }) : _encrypter = encrypter;

  factory EntriesEncryptedCSVFile.fromFile(
    File file, {
    required Encrypter encrypter,
  }) {
    if (file.existsSync()) {
      String _decrypted =
          decrypt(file.readAsStringSync(), encrypter: encrypter);
      List<String> _split = _decrypted.split('\n');
      List<List> _decoded = [];
      for (String s in _split) {
        if (s == '') continue;
        _decoded.add(csvDecode(s, recursive: true));
      }
      return EntriesEncryptedCSVFile<T>(
        file,
        encrypter: encrypter,
        value: Entries<T>.fromCSV(_decoded),
      );
    }
    file.createSync(recursive: true);
    EntriesEncryptedCSVFile<T> _file = EntriesEncryptedCSVFile<T>(file,
        encrypter: encrypter, value: Entries<T>());
    _file.saveSync();
    return _file;
  }

  String _save() {
    String _result = '';
    for (List _value in value.toCSV()) {
      _result += '${csvEncode(_value)}\n';
    }
    return _result == '' ? '' : encrypt(_result, encrypter: _encrypter);
  }

  @override
  Future<void> save() => _file.writeAsString(_save());

  @override
  void saveSync() => _file.writeAsStringSync(_save());
}
