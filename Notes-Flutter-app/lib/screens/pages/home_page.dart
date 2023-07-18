// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/colors/colors.dart';
import 'package:notes/widgets/constants.dart';
import 'package:notes/widgets/myNotesContainer.dart';

import '../../firebase_services/firebase_services.dart';
import '../home_screen/add_notes.dart';
import '../home_screen/edit_notes.dart';
import '../home_screen/note_detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  static const int maxWords = 3; // Maximum number of words to display
  List<DocumentSnapshot> notes = [];

  String truncateDescription(String description) {
    final words = description.split(' ');
    if (words.length <= maxWords) {
      return description;
    } else {
      final truncatedWords = words.sublist(0, maxWords);
        return '${truncatedWords.join(' ')}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 25,),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('AndroidNotesAppCloneTable')
                    .where('userPhoneNumber', isEqualTo: "+92 3264848783") // Replace `userPhoneNumber` with the actual user's phone number
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        final id = note.id;
                        final title = note['title'];
                        final description = note['description'];
                        final dateTime = note['dateTime'];

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Dismissible(
                              key: Key(index.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) async {
                                await FirebaseFirestore.instance.collection('NotesTable').doc(id).delete().then((value){
                                  setState(() {
                                    // Remove the dismissed item from the list
                                    notes.removeAt(index);
                                  });

                                  Constants.showSnackBar(context, msg: "Note deleted successfully.");
                                }).onError((error, stackTrace) {
                                  Constants.showSnackBar(context, msg: "Error with deletion. $error");
                                });
                              },
                              background: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                ),
                              ),
                              secondaryBackground: Container(
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                                  decoration: BoxDecoration(
                                    color: AppColors.blueAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.delete, color: AppColors.light,),
                                ),
                              ),
                              child: MyNotesContainer(
                                dateTime: dateTime,
                                title: truncateDescription(title),
                                description: truncateDescription(description),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NoteDetailsScreen(
                                        title: title,
                                        description: description,
                                        dateTime: dateTime,
                                      ),
                                    ),
                                  );
                                },
                                onLongPressed: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      NoteEditScreen(
                                        title: title,
                                        description: description,
                                        dateTime: dateTime,
                                        noteId: id,
                                      )),
                                  );
                                },
                              )),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddNotesUI())
          );
        },
        backgroundColor: AppColors.yellowRGBA,
        child: const Icon(Icons.add),
      ),
    );
  }
}
