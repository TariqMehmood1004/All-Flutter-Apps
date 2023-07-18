// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/firebase_services/firebase_services.dart';
import '../../colors/colors.dart';

class NoteEditScreen extends StatefulWidget {
  final String title;
  final String description;
  final String dateTime;
  final String noteId;

  NoteEditScreen({
    Key? key,
    required this.title,
    required this.description,
    String? dateTime,
    required this.noteId,
  }) : dateTime = dateTime ?? DateFormat.yMMMEd().format(DateTime.now()).toString(),
        super(key: key);

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = _descriptionController.text.length;
    });
  }

  final dateTime = DateFormat.yMMMEd().format(DateTime.now()).toString();
  bool _isConnected = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note', style: TextStyle(color: AppColors.black, fontFamily: "Segoe UI", fontSize: 25, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(AppColors.pink),
            ),
            onPressed: () {
              final editedTitle = _titleController.text;
              final editedDescription = _descriptionController.text;

              FirebaseServices.updateNote(
                context: context,
                collectionId: "NotesTable",
                editedTitle: editedTitle,
                editedDescription: editedDescription,
                editedDateTime: dateTime,
                noteId: widget.noteId, // Replace widget.noteId with the actual ID of the note
              );
              Navigator.of(context).pop();
            },
            child: Text('Save', style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(width: 20,),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 16),
              // ConnectivityIndicator(
              //   onChanged: (isConnected) {
              //     setState(() {
              //       _isConnected = isConnected;
              //     });
              //   },
              // ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _titleController,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Segoe UI",
                    color: AppColors.black,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text(
                      widget.dateTime,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      " |  $_characterCount Characters",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                maxLines: null,
                onChanged: (_) => _updateCharacterCount(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
