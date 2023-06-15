import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'dart:io';

import 'common.dart';
import 'bytes.dart';
import 'entries.dart';

class Images extends Entries<Bytes> {
  final Map<String, String> _indexes;
  final List<String> _freeIndexes;

  final String _path;
  final File _file;

  Encrypter _encrypter;
  set encrypter(Encrypter encrypter) => _encrypter = encrypter;

  Images._(
    this._path, {
    required Encrypter encrypter,
    required Map<String, Bytes> entries,
    required Map<String, String> indexes,
    required List<String> freeIndexes,
    required File file,
  })  : _encrypter = encrypter,
        _indexes = indexes,
        _freeIndexes = freeIndexes,
        _file = file,
        super(entries: entries);

  factory Images(String path, {required Encrypter encrypter}) {
    File file = File('$path${Platform.pathSeparator}images.json');
    if (file.existsSync()) {
      Map<String, dynamic> json =
          jsonDecode(decrypt(file.readAsStringSync(), encrypter: encrypter));
      Map<String, String> imageIndexes =
          (json['imageIndexes'] as Map<String, dynamic>?)?.map((key, value) =>
                  MapEntry(decrypt(key, encrypter: encrypter), value)) ??
              {};
      return Images._(path,
          encrypter: encrypter,
          entries: imageIndexes.map((key, value) => MapEntry(
              key,
              Bytes(key,
                  value: base64Decode(decrypt(
                      File(path + Platform.pathSeparator + value.toString())
                          .readAsStringSync(),
                      encrypter: encrypter))))),
          indexes: imageIndexes,
          freeIndexes:
              (json['freeIndexes'] as List<dynamic>?)?.cast<String>() ?? [],
          file: file);
    }
    file.createSync(recursive: true);
    Images images = Images._(path,
        encrypter: encrypter,
        entries: {},
        indexes: {},
        freeIndexes: [],
        file: file);
    images.saveSync();
    return images;
  }

  @override
  Map<String, dynamic> toJson() => {
        'imageIndexes': _indexes.map((key, value) =>
            MapEntry(encrypt(key, encrypter: _encrypter), value)),
        'freeImageIndexes': _freeIndexes,
      };

  @override
  void setEntry(Bytes entry) {
    super.setEntry(entry);

    if (!_indexes.containsKey(entry.key)) {
      if (_freeIndexes.isEmpty) {
        _indexes[entry.key] = _indexes.length.toRadixString(36);
      } else {
        _indexes[entry.key] = _freeIndexes.last;
        _freeIndexes.removeAt(_freeIndexes.length - 1);
      }
    }

    File('$_path${Platform.pathSeparator}${_indexes[entry.key]}.enc')
      ..createSync()
      ..writeAsStringSync(
          encrypt(base64Encode(entry.value), encrypter: _encrypter));
  }

  @override
  void removeEntry(String key) {
    super.removeEntry(key);
    File('$_path${Platform.pathSeparator}${_indexes[key]}.enc').deleteSync();
    _indexes.remove(key);
    saveSync();
  }

  Future<void> save() =>
      _file.writeAsString(encrypt(jsonEncode(this), encrypter: _encrypter));

  void saveSync() =>
      _file.writeAsStringSync(encrypt(jsonEncode(this), encrypter: _encrypter));
}
