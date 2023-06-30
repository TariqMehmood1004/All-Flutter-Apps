
import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFYPProject extends StatefulWidget {
  const AddFYPProject({super.key});

  @override
  State<AddFYPProject> createState() => _AddTimeTableControllerState();
}

class _AddTimeTableControllerState extends State<AddFYPProject> {

  final _taskTime = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final _titleOfFyp = TextEditingController();
  final _description = TextEditingController();
  final _toMembers = TextEditingController();
  final _supervisor = TextEditingController();


  Future<void> fypProjectAdd(String fypTitle, String description, String members, String supervisor) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document reference in a "fypProjects" collection
      DocumentReference projectRef = firestore.collection('fypProjects').doc();

      // Create a map with the project details
      Map<String, dynamic> projectData = {
        'FYP_Title': fypTitle,
        'Description': description,
        'Members': members,
        'Supervisor': supervisor,
      };

      // Add the project data to the Firestore document
      await projectRef.set(projectData);

      showSnackBar(msg: 'FYP project added successfully!');
    } catch (e) {
      showSnackBar(msg: 'Error adding FYP project: $e');
    }
  }

  void showSnackBar({String msg = "message"}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.snackBarBGColor3,
      content: Text('Yay! ${msg.toString()}', style: TextStyle(color: AppColors.white),),
      action: SnackBarAction(
        label: 'Ok',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final _formKey = GlobalKey<FormState>();

  // Function to show the popup dialog
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBGColor,
          content: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Assign FYProject".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      letterSpacing: 0.87,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleOfFyp,
                          decoration: InputDecoration(
                            labelText: "FYP Project Title",
                            icon: const Icon(Icons.title_outlined),
                            iconColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0, fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 15.0),
                        TextField(
                          controller: _description,
                          decoration: InputDecoration(
                            labelText: "Description about the project",
                            icon: const Icon(Icons.description_outlined),
                            iconColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0, fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                        const SizedBox(height: 15.0),
                        TextField(
                          controller: _toMembers,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: "Member (s)",
                            labelStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            icon: const Icon(Icons.person_2),
                            iconColor: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        TextField(
                          controller: _supervisor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Assign the Supervisor",
                            labelStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                            icon: const Icon(Icons.supervised_user_circle_sharp),
                            iconColor: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: (){
                fypProjectAdd(
                    _titleOfFyp.text.trim(),
                  _description.text.trim(),
                  _toMembers.text.trim(),
                  _supervisor.text.trim(),
                );
              },

              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22.0),
      decoration: BoxDecoration(
        color: AppColors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 80.0,
            decoration: BoxDecoration(
              color: AppColors.transparent,
            ),
            child: Column(
              children: [
                const SizedBox(height: 25.0,),
                Text("Today", style: TextStyle(color: AppColors.primary, fontSize: 18.0, fontWeight: FontWeight.bold),),
                const SizedBox(height: 5.0,),
                Text(_taskTime, style: TextStyle(fontSize: 10.0, color: AppColors.buttonColor2, fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              _showAddTaskDialog();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(
                  width: 1.0,
                  color: AppColors.color1,
                ),
              ), child: Text(
                'Add Project',
                style: TextStyle(
                  color: AppColors.primary,
                    fontSize: 12.0,
fontWeight: FontWeight.w600,
                    ),
            ),
            ),
          ),
        ],
      ),
    );
  }
}
