// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:app/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
    await FirebaseFirestore.instance.collection('users').orderBy('name').get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchResultList() {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> showResult = [];
    if (_searchController.text.isNotEmpty) {
      showResult = _allResults.where((result) {
        final name = result['name'].toString().toLowerCase();
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
      margin: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
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
                        title: Text(result['name'].toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(result['email'].toString()),
                            Text(result['userRole'].toString()),
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Text(
                            result['blocked'] ? 'Blocked' : 'Not Blocked',
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
          )
        ],
      ),
    );
  }
}
