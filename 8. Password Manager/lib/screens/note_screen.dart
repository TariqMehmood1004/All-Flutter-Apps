import 'package:flutter/material.dart';
import '../common/common.dart';
import '../db/loaded_account.dart';
import '../db/note.dart';
import '../pmp/theme.dart';
import '../pmp/widgets/entry_screen_appbar.dart';
import '../pmp/widgets/padding.dart';
import '../pmp/widgets/record_button.dart';
import 'main_screen.dart';
import 'edit_note_screen.dart';
import 'notes_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  static const routeName = '/note';

  @override
  State<StatefulWidget> createState() => _NoteScreen();
}

class _NoteScreen extends State<NoteScreen> {
  final LoadedAccount _account = data.loadedAccount!;

  void _onRemovePressed(Note note) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: PmpTheme.dialogShape,
            title: const Text('Remove note'),
            content: const Text('Notes can only be restored from a backup.'),
            actions: [
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color.fromARGB(255, 238, 241, 243)),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Color.fromARGB(255, 234, 240, 243)),
                ),
                onPressed: () {
                  _account.removeNote(note.key);
                  Navigator.popUntil(
                      context, (r) => r.settings.name == MainScreen.routeName);
                  _account.saveNotes().whenComplete(() =>
                      Navigator.pushNamed(context, NotesScreen.routeName));
                },
              )
            ],
          );
        });
  }

  void _onEditPressed(Note note) {
    Navigator.pushNamed(
      context,
      EditNoteScreen.routeName,
      arguments: note,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Note note = ModalRoute.of(context)!.settings.arguments as Note;
    return Scaffold(
      appBar: EntryScreenAppBar(
        title: const Center(
            child: Text(
          'Note',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        )),
        onRemovePressed: () => _onRemovePressed(note),
        onEditPressed: () => _onEditPressed(note),
      ),
      body: ListView(children: [
        if (note.title != '')
          PmpPadding(RecordButton(title: 'Title', value: note.title)),
        if (note.note != '')
          PmpPadding(RecordButton(
            title: 'Note',
            value: note.note,
            valueAlign: TextAlign.left,
          )),
      ]),
    );
  }
}
