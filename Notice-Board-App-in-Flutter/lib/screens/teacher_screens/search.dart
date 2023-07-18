import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../colors/contants.dart';

class SearchTeacher extends StatefulWidget {
  const SearchTeacher({super.key});

  @override
  State<SearchTeacher> createState() => _ShowAllTasksState();
}

class _ShowAllTasksState extends State<SearchTeacher> {

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
        .collection('TeacherDB')
        .orderBy('Assignment_Topic')
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
        final name = result['Assignment_Topic'].toString().toLowerCase();
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
                              result['Assignment_Topic'].toString(),
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
                                Text(result['Assignment_Title'].toString()),
                                Text(result['Course_Name'].toString()),
                                Text(result['Start_Time'].toString()),
                                Text(result['Deadline_Time'].toString()),
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

