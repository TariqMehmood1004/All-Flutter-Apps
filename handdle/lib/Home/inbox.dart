// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handdle/firebase_services/firebase_services.dart';
import 'package:handdle/models/chat_messages_model.dart';
import 'package:handdle/models/users_model.dart';
import 'package:handdle/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../Auth/apis.dart';
import 'calling.dart';

class Inbox extends StatefulWidget {
  const Inbox({
    super.key,
    required this.chatUserModel,
  });

  final ChatUserModel chatUserModel;

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final TextEditingController _messageController = TextEditingController();

  bool _isRecording = false;
  String _sendButtonIcon = 'send';

  bool isOnline = false;

  List<MessagesModel> listMessageModel = [];

  void _sendMessage(String message) {
    // Implement your logic for sending the message
    if (kDebugMode) {
      print('Sending message: $message');
    }
    _messageController.clear();
  }

  void _openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    // Handle the picked image
    if (image != null) {
      // Implement logic to handle the image
    }
  }

  void _openFiles() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    // Handle the picked file
    if (file != null) {
      // Implement logic to handle the file
    }
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      if (_isRecording) {
        _sendButtonIcon = 'mic';
      } else {
        _sendButtonIcon = 'send';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        color: Colors.grey[200],
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: _openFiles,
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: _openCamera,
            ),
            Expanded(
              child: TextFormField(
                controller: _messageController,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      _sendButtonIcon = 'mic';
                    } else {
                      _sendButtonIcon = 'send';
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type a message...',
                ),
              ),
            ),
            IconButton(
              icon: Icon(_sendButtonIcon == 'mic' ? Icons.mic : Icons.send),
              onPressed: () {
                if (_sendButtonIcon == 'mic') {
                  _toggleRecording();
                } else {
                  String message = _messageController.text.trim();
                  if (message.isNotEmpty) {
                    _sendMessage(message);
                  }
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Expanded(
          child: StreamBuilder(
            stream: FirebaseServices.getUserInfo(widget.chatUserModel),
            builder: (context, snapshot) {
              final data = snapshot.data!.docs;
              final list =
                  data.map((e) => ChatUserModel.fromJson(e.data())).toList() ??
                      [];

              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 16.5,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          APIs.cachedNetworkImage(
                            context: context,
                            imageUrl: list.isNotEmpty
                                ? list[0].image
                                : widget.chatUserModel.image,
                            isOnline: list[0].isOnline,
                            radius: 23,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list.isNotEmpty
                                    ? list[0].name
                                    : widget.chatUserModel.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.35,
                                ),
                              ),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(
                                list.isNotEmpty
                                    ? list[0].isOnline
                                        ? 'Online'
                                        : APIs.getLastActiveTime(
                                            context: context,
                                            lastActive:
                                                list[0].lastActive.toString())
                                    : APIs.getLastActiveTime(
                                        context: context,
                                        lastActive:
                                            widget.chatUserModel.lastActive),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                child: const Icon(Icons.call),
                onTap: () {
                  Get.to(() => const CallingScreen());
                  // Add your search functionality here
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: 35,
              height: 35,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8)),
              child: GestureDetector(
                child: Icon(
                  Icons.more_vert,
                  color: primaryColor,
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseServices.getAllChatMessages(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox();

                  case ConnectionState.active:
                  case ConnectionState.done:
                    listMessageModel.add(
                      MessagesModel(
                        fromId: FirebaseServices.currentUser.uid,
                        toId: "Tariq Mehmood",
                        msg: "Hey, how are you?",
                        sentTime: "12:12 AM",
                        readTime: "",
                        type: Type.text,
                      ),
                    );

                    listMessageModel.add(
                      MessagesModel(
                        fromId: "Tariq Mehmood",
                        toId: FirebaseServices.currentUser.uid,
                        msg: "I'm fine!",
                        sentTime: "12:15 AM",
                        readTime: "",
                        type: Type.text,
                      ),
                    );
                    log("Message: $listMessageModel");
                    if (listMessageModel.isNotEmpty) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: listMessageModel.length,
                        itemBuilder: (context, index) {
                          return Text(listMessageModel[index].msg.toString());
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("Say, hi! 👏"),
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
