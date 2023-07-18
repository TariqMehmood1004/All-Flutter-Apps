

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../colors/colors.dart';

class ShowTimeTableScreen extends StatefulWidget {
  const ShowTimeTableScreen({super.key});

  @override
  State<ShowTimeTableScreen> createState() => _ShowTimeTableScreenState();
}

class _ShowTimeTableScreenState extends State<ShowTimeTableScreen> {
  final _taskCollection = FirebaseFirestore.instance.collection('TimeTableTasks');


  final _searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allResults = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _resultLists = [];

  @override
  void initState() {
    super.initState();
    getUsersStream();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    searchResultList();
  }

  Future<void> getUsersStream() async {
    final data =
    await FirebaseFirestore.instance.collection('TimeTableTasks').orderBy('title').get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchResultList() {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> showResult = [];
    if (_searchController.text.isNotEmpty) {
      showResult = _allResults.where((result) {
        final name = result['title'].toString().toLowerCase();
        final query = _searchController.text.toLowerCase();
        return name.contains(query);
      }).toList();
    } else {
      showResult = List<QueryDocumentSnapshot<Map<String, dynamic>>>.from(_allResults);
    }

    setState(() {
      _resultLists = showResult;
    });
    return showResult;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
         Container(
           padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2.0),
           margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
           child: Column(
             children: [
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
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
               ListView.builder(
                 shrinkWrap: true,
                 itemCount: _resultLists.length,
                 itemBuilder: (context, index) {
                   final result = _resultLists[index].data();
                   return Container(
                     margin: const EdgeInsets.only(bottom: 5.0),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(12.0),
                       color: AppColors.backgroundLightGrey,
                     ),
                     child: ListTile(
                       contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                       title: Text(result['title'].toString()),
                       trailing: Container(
                         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                         decoration: BoxDecoration(
                           color: Colors.grey.shade200,
                           borderRadius: BorderRadius.circular(40.0),
                         ),
                         child: Text(
                           result['time'],
                           style: TextStyle(
                             color: AppColors.primary,
                             fontSize: 12.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ),
                   );
                 },
               ),
             ],
           ),
         ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12.0),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
               Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0), child: Align(alignment: Alignment.topLeft, child: Text(
                 "Time Table Schedule",
                 style: TextStyle(
                   color: AppColors.primary,
                   fontWeight: FontWeight.bold,
                   fontSize: 16.0,
                 ),
               ),),),
                const Divider(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _taskCollection.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Text('No tasks found.');
                      }
                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> task =
                            document.data() as Map<String, dynamic>;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 2.0),
                              decoration: BoxDecoration(
                                color: AppColors.transparent,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: AppColors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3.0),
                                  title: Text(task['title'],
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  subtitle: Text(task['time'],
                                    style: TextStyle(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              )
                            );
                          }).toList(),
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
    );
  }
}
