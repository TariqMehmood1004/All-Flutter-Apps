// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:characters/characters.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'dart:io';

// ignore: constant_identifier_names
const String Version = '0.11.1';
const String syncVersion = Version;
const String accountVersion = Version;

void copyDirectorySync(Directory source, Directory destination) {
  destination.createSync(recursive: true);
  source.listSync(recursive: false).forEach((var entity) {
    if (entity is Directory) {
      var newDirectory = Directory(
          path.join(destination.absolute.path, path.basename(entity.path)));
      newDirectory.createSync();

      copyDirectorySync(entity.absolute, newDirectory);
    } else if (entity is File) {
      entity.copySync(path.join(destination.path, path.basename(entity.path)));
    }
  });
}

Future<void> copyDirectory(Directory source, Directory destination) async {
  await for (var entity in source.list(recursive: false)) {
    if (entity is Directory) {
      var newDirectory = Directory(
          path.join(destination.absolute.path, path.basename(entity.path)));
      await newDirectory.create();
      await copyDirectory(entity.absolute, newDirectory);
    } else if (entity is File) {
      await entity
          .copy(path.join(destination.path, path.basename(entity.path)));
    }
  }
}

bool? boolFromString(String value) {
  if (value == 'true') return true;
  if (value == 'false') return false;
  return null;
}

Encrypter getEncrypter(String password) {
  if (password.length > 32) {
    throw Exception('Password is longer than 32 characters');
  }
  int a = 32 - password.length;
  password += ' ' * a;
  return Encrypter(AES(Key.fromUtf8(password)));
}

Digest getHash(String value) => sha512.convert(utf8.encode(value));

String encrypt(String data, {required Encrypter encrypter}) {
  if (data.isEmpty) return '';
  return encrypter
      .encrypt(
        data,
        iv: IV.fromLength(16),
      )
      .base64;
}

String decrypt(String data, {required Encrypter encrypter}) {
  if (data.isEmpty) return '';
  return encrypter.decrypt64(
    data,
    iv: IV.fromLength(16),
  );
}

String csvEncode(List object) {
  String _encode(dynamic record) {
    if (record is String) {
      return record
          .replaceAll('\\', '\\\\')
          .replaceAll('\n', '\\n')
          .replaceAll(',', '\\,')
          .replaceAll('[', '\\[');
    }
    if (record is List) {
      String encoded = '[';
      if (record.isNotEmpty) {
        for (int i = 0; i < record.length - 1; i++) {
          encoded += '${_encode(record[i])},';
        }
        encoded += _encode(record[record.length - 1]);
      }
      encoded += ']';
      return encoded;
    }
    return record.toString();
  }

  String result = '';
  if (object.isNotEmpty) {
    for (int i = 0; i < object.length - 1; i++) {
      result += '${_encode(object[i])},';
    }
    result += _encode(object[object.length - 1]);
  }
  return result;
}

List csvDecode(String source,
    {bool recursive = false, bool decodeBools = false}) {
  List _decode(String source) {
    if (source == '') return [];

    List<dynamic> entry = [''];
    int v = 0;
    int depth = 0;
    Iterator<String> characters = source.characters.iterator;
    bool escapeDetected = false;

    void _convert() {
      if (!decodeBools) return;
      if (entry[v] == 'false') {
        entry[v] = false;
      }

      if (entry[v] == 'true') {
        entry[v] = true;
      }
    }

    while (characters.moveNext()) {
      String currentCharacter = characters.current;

      if (!escapeDetected) {
        if (characters.current == ',') {
          _convert();
          v++;
          entry.add('');
          continue;
        } else if (characters.current == '[') {
          entry[v] += '[';
          depth++;
          while (characters.moveNext()) {
            entry[v] += characters.current;
            if (characters.current == ']') {
              depth--;
              if (depth == 0) break;
            }
            if (characters.current == '\\') {
              escapeDetected = true;
            }
            if (escapeDetected) {
              escapeDetected = false;
              continue;
            }
            if (characters.current == '[') {
              depth++;
            }
          }
          if (recursive) {
            if (entry[v] == '[]') {
              entry[v] = [];
              continue;
            }
            String entryString = entry[v];
            entry[v] =
                _decode(entryString.substring(1, entryString.length - 1));
          }
          continue;
        } else if (characters.current == '\\') {
          escapeDetected = true;
          continue;
        }
      } else {
        if (characters.current == 'n') {
          currentCharacter = '\n';
        }
      }

      entry[v] += currentCharacter;
      escapeDetected = false;
    }

    _convert();

    return entry;
  }

  return _decode(source);
}
