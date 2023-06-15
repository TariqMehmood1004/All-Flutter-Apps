import 'entries.dart';
import 'entries_encrypted_csv_file.dart';
import 'entry.dart';

typedef Notes = Entries<Note>;

typedef NotesFile = EntriesEncryptedCSVFile<Note>;

class Note extends Entry<Note> {
  String title;
  String note;

  Note({
    String? key,
    this.title = '',
    this.note = '',
  }) : super(key ?? DateTime.now().toUtc().toIso8601String());

  Note.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        note = json['note'] ?? '',
        super(json['key'] ?? DateTime.now().toUtc().toIso8601String());

  Note.fromCSV(List csv)
      : title = csv[1] ?? '',
        note = csv[2] ?? '',
        super(csv[0] ?? DateTime.now().toUtc().toIso8601String());

  @override
  int compareTo(Note other) => title.compareTo(other.title);

  @override
  Map<String, dynamic> toJson() => {
        'key': key,
        'title': title,
        'note': note,
      };

  @override
  List toCSV() => [
        key,
        title,
        note,
      ];
}
