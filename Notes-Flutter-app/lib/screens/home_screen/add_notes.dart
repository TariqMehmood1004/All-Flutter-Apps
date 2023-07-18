
// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes/colors/colors.dart';
import 'package:notes/firebase_services/firebase_services.dart';

import '../../widgets/constants.dart';

class AddNotesUI extends StatefulWidget {
  const AddNotesUI({super.key});

  @override
  State<AddNotesUI> createState() => _AddNotesUIState();
}

class _AddNotesUIState extends State<AddNotesUI> {

  final dateTime = DateFormat.yMMMEd().format(DateTime.now()).toString();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    descriptionController.addListener(_updateCharacterCount);
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = descriptionController.text.length;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.0),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.undo),
                    const SizedBox(width: 15,),
                    const Icon(Icons.redo),
                    const SizedBox(width: 15,),
                    GestureDetector(
                      onTap: () {
                       FirebaseServices().createNotes(
                         context,
                            collectionName: "NotesTable",
                            title: titleController.text.trim().toString(),
                            description: descriptionController.text.trim().toString()).then((value){
                          Timer(
                              const Duration(milliseconds: 750), (){
                            Navigator.of(context).pop();
                          });
                        }).onError((error, stackTrace) {
                          Constants.showSnackBar(context, msg: error.toString());
                        });
                      },
                      child: const FaIcon(FontAwesomeIcons.solidSave),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Form(
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Arial",
                          ),
                          decoration: const InputDecoration(
                              hintText: "Title goes here",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: "Arial",
                              ),
                              border: InputBorder.none
                          ),
                          keyboardType: TextInputType.text,
                        ),

                        const SizedBox(height: 15,),

                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                dateTime,
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

                        const SizedBox(height: 15,),

                        TextField(
                          controller: descriptionController,
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                            fontFamily: "Arial",
                          ),
                          decoration: const InputDecoration(
                              hintText: "Description",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w100,
                                fontSize: 14,
                                fontFamily: "Arial",
                              ),
                              border: InputBorder.none
                          ),
                          onChanged: (_){
                            _updateCharacterCount();
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 30,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
