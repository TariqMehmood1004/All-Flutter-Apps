// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatConversation {
  final String contactName;
  final String lastMessage;
  final String timestamp;

  ChatConversation({
    required this.contactName,
    required this.lastMessage,
    required this.timestamp,
  });
}

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<ChatConversation> conversations = [
    ChatConversation(
      contactName: 'John Doe',
      lastMessage: 'Hey, how are you?',
      timestamp: '10:30 AM',
    ),
    ChatConversation(
      contactName: 'Jane Smith',
      lastMessage: 'I will be there in 10 minutes.',
      timestamp: 'Yesterday',
    ),
    // Add more conversations
  ];

  final TextEditingController _messageController = TextEditingController();
  IconData _sendButtonIcon = Icons.mic;
  bool _isRecording = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      _sendButtonIcon = _isRecording ? Icons.stop : Icons.mic;
    });

    if (_isRecording) {
      // Start recording voice message
      Fluttertoast.showToast(msg: 'Recording started');
    } else {
      // Stop recording voice message
      Fluttertoast.showToast(msg: 'Recording stopped');
    }
  }

  void _sendMessage(String message) {
    Fluttertoast.showToast(msg: 'Message sent: $message');
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(conversation.contactName.substring(0, 1)),
                  ),
                  title: Text(conversation.contactName),
                  subtitle: Text(conversation.lastMessage),
                  trailing: Text(conversation.timestamp),
                  onTap: () {
                    // Handle tapping on a chat conversation
                    // Navigate to the chat screen for this contact
                  },
                );
              },
            ),
          ),
          const Divider(height: 0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: Colors.grey[200],
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Handle opening files
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    // Handle opening the camera
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          _sendButtonIcon = Icons.mic;
                        } else {
                          _sendButtonIcon = Icons.send;
                        }
                      });
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(_sendButtonIcon),
                  onPressed: () {
                    if (_sendButtonIcon == Icons.mic) {
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
        ],
      ),
    );
  }
}
