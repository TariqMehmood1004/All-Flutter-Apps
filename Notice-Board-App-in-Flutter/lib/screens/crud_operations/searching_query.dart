
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:app/colors/contants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BottomSheetModel {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  Future<void> performSearch(BuildContext context, String searchQuery) async {
    // Access the Firestore collection that contains the user data
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    // Perform the search query using Firestore
    QuerySnapshot querySnapshot = await usersCollection
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff')
        .get();

    // Clear the previous search results
    searchResults.clear();
    searchResults.addAll(
      querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList(),
    );

    showSnackBar(context, msg: searchResults.toString());
    debugPrint("You have searched: ${searchResults.toString()}");
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final BottomSheetModel _bottomSheetModel = BottomSheetModel();

  void _showSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _bottomSheetModel.searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      await _bottomSheetModel.performSearch(
                          context,
                          _bottomSheetModel.searchController.text.toString(),
                      );
                      // Update UI with search results
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _bottomSheetModel.searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  final searchResult = _bottomSheetModel.searchResults[index];
                  return ListTile(
                    title: Text(searchResult['name']),
                    subtitle: Text(searchResult['email']),
                    // Add more UI elements or actions for each search result if needed
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showSearchBottomSheet,
          child: Text('Open Search'),
        ),
      ),
    );
  }
}
