import 'package:encrypt/encrypt.dart';
import 'dart:io';

import 'csv_convertable.dart';
import 'entry_type.dart';
import 'json_convertable.dart';
import 'entries_encrypted_csv_file.dart';
import 'entry.dart';

class Entries<T extends Entry<T>> with JsonConvertable, CSVConvertable {
  final Map<String, T> _entries;
  Iterable<T> get entries => _entries.values;

  Entries({Map<String, T>? entries}) : _entries = entries ?? {};

  Entries.fromJson(Map<String, dynamic> json)
      : _entries = entriesFromJson(json);

  Entries.fromCSV(List<List> csv) : _entries = entriesFromCSV(csv);

  T? getEntry(String key) => _entries[key];

  void setEntry(T entry) {
    _entries[entry.key] = entry;
  }

  void removeEntry(String key) => _entries.remove(key);

  @override
  Map<String, dynamic> toJson() =>
      _entries.map((key, value) => MapEntry(key, value.toJson()));

  @override
  List<List> toCSV() {
    List<List<dynamic>> csv = [];
    for (T entry in entries) {
      csv.add(entry.toCSV());
    }
    return csv;
  }

  static Map<String, T> entriesFromJson<T>(Map<String, dynamic> json) {
    T Function(Map<String, dynamic>) fromJson =
        Entry.fromJson(entryTypeFromType(T)!) as T Function(
            Map<String, dynamic>);
    return json.map<String, T>(
        (key, value) => MapEntry(key, fromJson(value as Map<String, dynamic>)));
  }

  static Map<String, T> entriesFromCSV<T>(List<List<dynamic>> csv) {
    T Function(List<dynamic>) fromCSV =
        Entry.fromCSV(entryTypeFromType(T)!) as T Function(List<dynamic>);
    Map<String, T> entries = {};
    for (List<dynamic> entry in csv) {
      entries[entry[0]] = fromCSV(entry);
    }
    return entries;
  }

  static EntriesEncryptedCSVFile<T> fromFile<T extends Entry<T>>(
    File file, {
    required Encrypter encrypter,
  }) =>
      EntriesEncryptedCSVFile<T>.fromFile(
        file,
        encrypter: encrypter,
      );
}
