import 'package:flutter/material.dart';
import '../common/common.dart';
import '../db/loaded_account.dart';
import '../db/note.dart';
import '../pmp/widgets/entries_screen_appbar.dart';
import '../pmp/widgets/note_button_list_view.dart';
import 'main_screen.dart';
import 'note_screen.dart';
import 'search_screen.dart';
import 'edit_note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  static const routeName = '${MainScreen.routeName}/notes';

  @override
  State<StatefulWidget> createState() => _NotesScreen();
}

class _NotesScreen extends State<NotesScreen> {
  final LoadedAccount _account = data.loadedAccount!;

  void _onAddPressed() =>
      Navigator.pushNamed(context, EditNoteScreen.routeName);

  void _onSearchPressed() {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: (String terms) {
      final List<Note> found = [];
      // ignore: no_leading_underscores_for_local_identifiers
      final List<String> _terms = terms.trim().toLowerCase().split(' ');
      for (Note note in _account.notes) {
        {
          bool testNote(Note value) => note.key == value.key;

          if (found.any(testNote)) continue;
        }
        {
          int positiveCount = 0;
          for (String term in _terms) {
            if (note.title.toLowerCase().contains(term)) {
              positiveCount++;
              continue;
            }
          }
          if (positiveCount == _terms.length) {
            found.add(note);
          }
        }
      }
      return NoteButtonListView(
        notes: found,
        shouldSort: true,
        onPressed: (note) =>
            Navigator.pushNamed(context, NoteScreen.routeName, arguments: note),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EntriesScreenAppBar(
          title: const Center(
              child: Text('Notes',
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 250, 250),
                  ))),
          onSearchPressed: _onSearchPressed,
          onAddPressed: _onAddPressed),
      body: _account.notes.isEmpty
          ? CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                    children: [
                      const Spacer(flex: 7),
                      const Text(
                        'No notes',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton(
                          child: const Icon(Icons.add_rounded,
                              color: Colors.white),
                          onPressed: () => Navigator.pushNamed(
                              context, EditNoteScreen.routeName)),
                      const Spacer(flex: 7),
                    ],
                  ),
                ),
              ],
            )
          : NoteButtonListView(
              notes: data.loadedAccount!.notes.toList(),
              shouldSort: true,
              onPressed: (note) => Navigator.pushNamed(
                  context, NoteScreen.routeName,
                  arguments: note),
            ),
    );
  }
}
