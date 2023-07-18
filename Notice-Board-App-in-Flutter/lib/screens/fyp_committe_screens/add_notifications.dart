
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';

class AddNotifications extends StatefulWidget {
  const AddNotifications({super.key});

  @override
  State<AddNotifications> createState() => _AddNotificationsState();
}

class _AddNotificationsState extends State<AddNotifications> {

  final _titleOfFyp = TextEditingController();
  final _description = TextEditingController();
  final _assignedToMembers = TextEditingController();
  final _supervisor = TextEditingController();


  void _insertNotifications(String titleOfFYP, String description, String toMembers, String supervisor) async {

   try{
     FirebaseFirestore store = FirebaseFirestore.instance;
     CollectionReference collectionReference = store.collection("AssignFYProject");

     DocumentReference documentReference = collectionReference.doc();

     await documentReference.set(
         {
           'Title': _titleOfFyp,
           'Description': description,
           'Members': toMembers,
           'Supervisor': supervisor,
         }
     );
     showSnackBar(msg: "You have assigned the Project '$_titleOfFyp' to $toMembers.");
   }
   on FirebaseAuthException catch(e){
     showSnackBar(msg: e.code.toString());
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
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
                      controller: _assignedToMembers,
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
                    const SizedBox(height: 45.0),
                    InkWell(
                      onTap: () {
                        _insertNotifications(
                          _titleOfFyp.toString().trim(),
                          _description.toString().trim(),
                          _assignedToMembers.toString().trim(),
                          _supervisor.toString().trim()
                        );
                      },
                      child: Ink(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 250,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Icon(Icons.login, color: AppColors.primary,),
                              Text("Add Notification", style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
