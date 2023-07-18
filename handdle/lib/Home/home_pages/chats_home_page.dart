// // ignore_for_file: depend_on_referenced_packages
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:handdle/utils/colors.dart';
//
// import '../inbox.dart';
//
// class ChatsHomePage extends StatefulWidget {
//   const ChatsHomePage({super.key});
//
//   @override
//   State<ChatsHomePage> createState() => _ChatsHomePageState();
// }
//
// class _ChatsHomePageState extends State<ChatsHomePage> {
//   // Get the Firestore instance.
//
//   // Get the users collection.
//   CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection("users");
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       physics: const BouncingScrollPhysics(),
//       child: Container(
//         padding: EdgeInsets.all(size.width * 0.01),
//         width: double.infinity,
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(size.width * 0.05),
//               child: const Row(
//                 children: [
//                   Text(
//                     'Chats',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: ListTile(
//                 leading: Image.asset("images/archive.png"),
//                 title: const Text(
//                   'Archived',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             // Create a StreamBuilder widget to display the list of users.
//             StreamBuilder(
//               stream: usersCollection.snapshots(),
//               builder: (context, snapshot) {
//                 // If the snapshot is not yet complete, show a loading indicator.
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   // If the snapshot has an error, show an error message.
//                   return const Center(child: Text("Something went wrong"));
//                 } else {
//                   // If the snapshot has completed successfully, show the list of users.
//                   return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       // Return a ListTile widget for each user in the list.
//                       return ListTile(
//                         title: Text((snapshot.data!.docs[index].data()
//                             as Map<String, dynamic>)['phoneNumber']),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//             ListTile(
//               onTap: () {
//                 Get.to(() => const Inbox());
//               },
//               leading: const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.person),
//               ),
//               title: const Text(
//                 "Friends Hanging Out",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//               ),
//               subtitle: const Text(
//                 "I am hopping for a really a big discount",
//                 style: TextStyle(fontSize: 14),
//               ),
//               isThreeLine: true,
//               trailing: Column(
//                 children: [
//                   const Text("20.0"),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Image.asset("images/screw.png"),
//                 ],
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Get.to(() => const Inbox());
//               },
//               leading: const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.person),
//               ),
//               title: const Text(
//                 "Spotify",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//               ),
//               subtitle: const Text(
//                 "That's awesome!",
//                 style: TextStyle(fontSize: 14),
//               ),
//               isThreeLine: true,
//               trailing: SizedBox(
//                 width: 50,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const Text("20.10"),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         Image.asset("images/screw.png"),
//                         const SizedBox(
//                           width: 8,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(6),
//                           decoration: BoxDecoration(
//                               color: Colors.orange,
//                               borderRadius: BorderRadius.circular(50)),
//                           child: const Text(
//                             "14",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Get.to(() => const Inbox());
//               },
//               leading: const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.person),
//               ),
//               title: const Text(
//                 "Friends Hanging Out",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//               ),
//               subtitle: const Text(
//                 "I am hopping for a really a big discount",
//                 style: TextStyle(fontSize: 14),
//               ),
//               isThreeLine: true,
//               trailing: Column(
//                 children: [
//                   const Text("20.0"),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Image.asset("images/screw.png"),
//                 ],
//               ),
//             ),
//             ListTile(
//               onTap: () {
//                 Get.to(() => const Inbox());
//               },
//               leading: const CircleAvatar(
//                 radius: 25,
//                 child: Icon(Icons.person),
//               ),
//               title: const Text(
//                 "Spotify",
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//               ),
//               subtitle: const Text(
//                 "That's awesome!",
//                 style: TextStyle(fontSize: 14),
//               ),
//               isThreeLine: true,
//               trailing: SizedBox(
//                 width: 50,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const Text("20.10"),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         Image.asset("images/screw.png"),
//                         const SizedBox(
//                           width: 8,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(6),
//                           decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.circular(50)),
//                           child: const Text(
//                             "14",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:handdle/Auth/apis.dart';
import 'package:intl/intl.dart';

import '../../firebase_services/firebase_services.dart';
import '../../models/users_model.dart';
import '../inbox.dart';

class ChatsHomePage extends StatefulWidget {
  const ChatsHomePage({super.key});

  @override
  _ChatsHomePageState createState() => _ChatsHomePageState();
}

class _ChatsHomePageState extends State<ChatsHomePage> {
  List<ChatUserModel> userList = [];
  // List<DocumentSnapshot> userList = [];
  bool isOnline = false;

  List<ChatUserModel> list = [];
  // list = data.map((e) => ChatUserModel.fromJson(e.data())).toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseServices.updateActiveStatus(true);

    SystemChannels.lifecycle.setMessageHandler((message) {
      log("Message: $message");
      if (message.toString().contains('resume')) {
        FirebaseServices.updateActiveStatus(true);
      }
      if (message.toString().contains('pause')) {
        FirebaseServices.updateActiveStatus(false);
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: const Row(
              children: [
                Text(
                  'Chats',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              leading: Image.asset("images/archive.png"),
              title: const Text(
                'Archived',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.01),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: StreamBuilder(
                stream: APIs.firestore.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error retrieving users');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.data!.docs;

                  list = data
                      .map((e) => ChatUserModel.fromJson(e.data()))
                      .toList();

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(size.width * 0.01),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Get.to(
                                    () => Inbox(
                                      chatUserModel: list[index],
                                    ),
                                  );
                                },
                                leading: APIs.cachedNetworkImage(
                                  context: context,
                                  imageUrl: list[index].image,
                                  isOnline: list[index].isOnline,
                                ),
                                title: Text(
                                  APIs.chooseFirstTwoWords(
                                      list[index].name.toString()),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  APIs.chooseToSplitWords(list[index].about, 6),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                                isThreeLine: true,
                                trailing: Column(
                                  children: [
                                    Text(
                                      DateFormat('mm:ss').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(list[index].lastActive),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset("images/screw.png"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  // for (var i in data) {
                  //   log(jsonEncode(i.data()));
                  // }

                  // return SingleChildScrollView(
                  //   scrollDirection: Axis.vertical,
                  //   physics: const BouncingScrollPhysics(),
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.all(size.width * 0.05),
                  //         child: const Row(
                  //           children: [
                  //             Text(
                  //               'Chats',
                  //               style: TextStyle(
                  //                   fontSize: 20, fontWeight: FontWeight.w500),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: ListTile(
                  //           leading: Image.asset("images/archive.png"),
                  //           title: const Text(
                  //             'Archived',
                  //             style: TextStyle(
                  //                 fontSize: 18, fontWeight: FontWeight.w600),
                  //           ),
                  //         ),
                  //       ),
                  //
                  //       // ListView builder
                  //       ListView.builder(
                  //         itemCount: list.length,
                  //         itemBuilder: (context, index) {
                  //           return Card(
                  //             child: ListTile(
                  //               leading: APIs.cachedNetworkImage(
                  //                   imageUrl: list[index].image),
                  //               title: Text(list[index].name),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //
                  //       // Column(
                  //       //   children: data.map((doc) {
                  //       //     String userName = doc['name'];
                  //       //     String image = doc['image'];
                  //       //     String about = doc['about'];
                  //       //     String lastActive = doc['lastActive'];
                  //       //     bool isOnline = doc['isOnline'];
                  //       //
                  //       //
                  //       //     return Container(
                  //       //       margin: const EdgeInsets.symmetric(vertical: 2.0),
                  //       //       decoration: BoxDecoration(
                  //       //         color: Colors.transparent,
                  //       //         borderRadius: BorderRadius.circular(6.0),
                  //       //       ),
                  //       //       child: ListTile(
                  //       //         onTap: () {
                  //       //           Get.to(
                  //       //             () => Inbox(
                  //       //               chatUserModel: list[0],
                  //       //             ),
                  //       //           );
                  //       //         },
                  //       //         leading: APIs.cachedNetworkImage(
                  //       //           context: context,
                  //       //           imageUrl: image,
                  //       //           isOnline: isOnline,
                  //       //         ),
                  //       //         title: Text(
                  //       //           APIs.chooseFirstTwoWords(userName.toString()),
                  //       //           style: const TextStyle(
                  //       //             fontWeight: FontWeight.w600,
                  //       //             fontSize: 18,
                  //       //           ),
                  //       //         ),
                  //       //         subtitle: Text(
                  //       //           APIs.chooseToSplitWords(about, 6),
                  //       //           style: const TextStyle(
                  //       //             fontSize: 13,
                  //       //             color: Colors.black54,
                  //       //           ),
                  //       //         ),
                  //       //         isThreeLine: true,
                  //       //         trailing: Column(
                  //       //           children: [
                  //       //             Text(
                  //       //               DateFormat('mm:ss').format(
                  //       //                 DateTime.fromMillisecondsSinceEpoch(
                  //       //                   int.parse(lastActive),
                  //       //                 ),
                  //       //               ),
                  //       //             ),
                  //       //             const SizedBox(
                  //       //               height: 10,
                  //       //             ),
                  //       //             Image.asset("images/screw.png"),
                  //       //           ],
                  //       //         ),
                  //       //       ),
                  //       //     );
                  //       //   }).toList(),
                  //       // ),
                  //     ],
                  //   ),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
