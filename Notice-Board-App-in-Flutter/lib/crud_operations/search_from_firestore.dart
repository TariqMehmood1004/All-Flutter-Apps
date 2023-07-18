

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchingFromFirebaseFirestore {
  final _searchController = TextEditingController();

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _allResults = [];
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _resultLists = [];


  void _onSearchChanged() {
    searchResultList();
  }

  Future<void> getSearchStream(String collectionName, String orderBy) async {
    final data = await FirebaseFirestore.instance.collection(collectionName).orderBy(orderBy).get();
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
    return showResult;
  }

}