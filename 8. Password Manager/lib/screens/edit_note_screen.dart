import 'package:app/common/common.dart';
import 'package:app/db/loaded_account.dart';
import 'package:app/db/note.dart';
import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/edit_screen_appbar.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:flutter/material.dart';
import 'note_screen.dart';
import 'notes_screen.dart';
import 'splash_screen.dart';
import 'main_screen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({Key? key}) : super(key: key);

  static const routeName = '${NoteScreen.routeName}/edit';

  @override
  State<StatefulWidget> createState() => _EditNoteScreen();
}

class _EditNoteScreen extends State<EditNoteScreen> {
  bool _isLoaded = false;
  bool _isNew = true;

  String? _key;
  String _title = '';
  String _note = '';

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      Object? args = ModalRoute.of(context)!.settings.arguments;
      _isNew = args == null;
      if (!_isNew) {
        Note noteArgs = args as Note;
        _key = noteArgs.key;
        _title = noteArgs.title;
        _note = noteArgs.note;
      }
      _isLoaded = true;
    }

    return Scaffold(
      appBar: EditScreenAppBar(
        title: 'note',
        isNew: _isNew,
        onSave: () {
          final LoadedAccount account = data.loadedAccount!;
          Note noteArgs = Note(
            key: _key,
            title: _title,
            note: _note,
          );
          account.setNote(noteArgs);
          Navigator.pushNamed(context, SplashScreen.routeName);
          account.saveNotes().whenComplete(() {
            Navigator.popUntil(
                context, (r) => r.settings.name == MainScreen.routeName);
            Navigator.pushNamed(context, NotesScreen.routeName);
            Navigator.pushNamed(context, NoteScreen.routeName,
                arguments: noteArgs);
          });
        },
      ),
      body: ListView(children: [
        const SizedBox(
          height: 30,
        ),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          initialValue: _title,
          decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.black), labelText: 'Title'),
          onChanged: (value) => setState(() => _title = value.trim()),
        )),
        PmpPadding(TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          initialValue: _note,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black),
            labelText: 'Note',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(color: PmpTheme.lightContentColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide:
                  const BorderSide(color: PmpTheme.darkContentSecondaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: const BorderSide(color: PmpTheme.lightContentColor),
            ),
          ),
          onChanged: (value) => setState(() => _note = value),
        )),
      ]),
    );
  }
}
