import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../colors/contants.dart';

class SearchFYP extends StatefulWidget {
  const SearchFYP({super.key});

  @override
  State<SearchFYP> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<SearchFYP> {

  final _taskCollection = FirebaseFirestore.instance.collection('fypProjects');

  // Variables to store the task input values
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _membersController = TextEditingController();
  final _supervisorController = TextEditingController();



  final _searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allResults = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _resultLists = [];

  @override
  void initState() {
    super.initState();
    getUsersStream();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    searchResultList();
  }

  Future<void> getUsersStream() async {
    final data = await FirebaseFirestore.instance
        .collection('fypProjects')
        .orderBy('FYP_Title')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchResultList() {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> showResult = [];
    if (_searchController.text.isNotEmpty) {
      showResult = _allResults.where((result) {
        final name = result['FYP_Title'].toString().toLowerCase();
        final query = _searchController.text.toLowerCase();
        return name.contains(query);
      }).toList();
    } else {
      showResult =
      List<QueryDocumentSnapshot<Map<String, dynamic>>>.from(_allResults);
    }

    setState(() {
      _resultLists = showResult;
    });
    return showResult;
  }


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _membersController.dispose();
    _supervisorController.dispose();
    super.dispose();
  }

  void _deleteTask(String id) async {
    try {
      await _taskCollection.doc(id).delete();
      showSnackBar(msg: "Project deleted successfully.");
    } on FirebaseAuthException catch (e) {
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

  showModalBox(String userRole) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
            color: AppColors.cardBGColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20.0,),
                Text(
                  'Edit FYP',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 5.0,),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _membersController,
                  decoration: const InputDecoration(labelText: 'Members'),
                ),
                TextField(
                  controller: _supervisorController,
                  decoration: const InputDecoration(labelText: 'Supervisor'),
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.color1,
                          ),
                        ), child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        FirebaseFirestore.instance.collection("fypProjects").doc(userRole).update(
                            {
                              'FYP_Title': _titleController.text.trim(),
                              'Description': _descriptionController.text.trim(),
                              'Members': _membersController.text.trim(),
                              'Supervisor': _supervisorController.text.trim(),
                            }
                        );
                        showSnackBar(msg: "Successfully updated.");
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.transparent,
                          ),
                        ), child: Text(
                        'Update',
                        style: TextStyle(
                          color: AppColors.cardBGColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 2.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                    width: double.infinity,
                    child: Text(
                      "Search the list",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4.0, left: 12.0, right: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _resultLists.length,
                      itemBuilder: (context, index) {
                        final result = _resultLists[index].data();
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey.shade100,
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 7.0),
                            title: Text(
                              result['FYP_Title'].toString().toUpperCase(),
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(result['Description'].toString()),
                                Text(result['Members'].toString()),
                                Text(result['Supervisor'].toString()),
                              ],
                            ),
                          ),
                        );
                      },
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

