import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:handdle/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'calling.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {

  final TextEditingController _messageController = TextEditingController();
  bool _isRecording = false;
  String _sendButtonIcon = 'send';

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
    Size size = MediaQuery.of(context).size;
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
        title: const Row(
          children: [
            CircleAvatar(child: Icon(Icons.person),),
            SizedBox(width: 10,),
            Text("Kristin Watson",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
          ],
        ),
        // automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: IconButton(
                color: primaryColor,
                icon: const Icon(Icons.call),
                onPressed: () {
                  Get.to(() => const CallingScreen());
                  // Add your search functionality here
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: IconButton(
                icon: Icon(Icons.more_vert, color: primaryColor,),
                onPressed: (){

                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.01),
        child: Column(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.7,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xffF4F6F9),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10))
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("The learning is so fast, I even have a\n hard time keeping up with it"),
                        Text("19.59"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.7,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: Color(0xffF4F6F9),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10))
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("The learning is so fast, I even have a\n hard time keeping up with it"),
                        Text("19.59"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.7,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: Color(0xffF4F6F9),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10))
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("The learning is so fast, I even have a\n hard time keeping up with it"),
                        Text("19.59"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: size.width * 0.7,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: Color(0xffeaf5fb),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topLeft: Radius.circular(10))
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("The learning is so fast, I even have a\n hard time keeping up with it"),
                        Text("19.59"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: size.width * 0.7,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: Color(0xffeaf5fb),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topLeft: Radius.circular(10))
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("The learning is so fast, I even have a\n hard time keeping up with it"),
                        Text("19.59"),
                      ],
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
