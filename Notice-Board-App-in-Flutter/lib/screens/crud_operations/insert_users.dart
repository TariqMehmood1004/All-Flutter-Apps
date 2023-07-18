// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeBoardApp extends StatelessWidget {
  const NoticeBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notice Board App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoticeBoardScreen(),
    );
  }
}

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  CollectionReference noticesCollection =
  FirebaseFirestore.instance.collection('notices');

  final TextEditingController _noticeController = TextEditingController();

  @override
  void dispose() {
    _noticeController.dispose();
    super.dispose();
  }

  void _addNotice(String notice) {
    noticesCollection.add({'content': notice});
    _noticeController.clear();
  }

  void _deleteNotice(String noticeId) {
    noticesCollection.doc(noticeId).delete();
  }

  void _updateNotice(String noticeId, String updatedNotice) {
    noticesCollection.doc(noticeId).update({'content': updatedNotice});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice Board App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _noticeController,
              decoration: InputDecoration(
                labelText: 'Add Notice',
                suffixIcon: IconButton(
                  onPressed: () {
                    _addNotice(_noticeController.text);
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: noticesCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error retrieving notices');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<DocumentSnapshot> notices = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: notices.length,
                  itemBuilder: (context, index) {
                    String noticeId = notices[index].id;
                    String noticeContent = notices[index]['content'];

                    return ListTile(
                      title: Text(noticeContent),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _updateNoticeDialog(noticeId, noticeContent);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteNotice(noticeId);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateNoticeDialog(String noticeId, String currentContent) {
    TextEditingController updateNoticeController = TextEditingController(text: currentContent);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Notice'),
          content: TextField(
            controller: updateNoticeController,
            decoration: const InputDecoration(
              labelText: 'New Notice',
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
              onPressed: () {
                _updateNotice(noticeId, updateNoticeController.text);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
