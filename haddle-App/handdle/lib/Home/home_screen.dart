import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handdle/Home/inbox.dart';
import 'package:handdle/utils/colors.dart';

import '../business/business_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabController? _controller;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          onPressed: () {},
          label: Image.asset("images/message.png"),
          // child:
        ),
        appBar: AppBar(
          title: const Text(
            "Handdle",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  color: primaryColor,
                  icon: const Icon(Icons.search),
                  onPressed: () {
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
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: primaryColor,
            labelStyle: const TextStyle(fontSize: 18),
            controller: _controller,
            tabs: const [
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Following',
              ),
              Tab(
                text: 'Calls',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.01),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: const Row(
                      children: [
                        Text(
                          'Chats',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => const Inbox());
                    },
                    leading: const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    ),
                    title: const Text(
                      "Friends Hanging Out",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    subtitle: const Text(
                      "I am hopping for a really a big discount",
                      style: TextStyle(fontSize: 14),
                    ),
                    isThreeLine: true,
                    trailing: Column(
                      children: [
                        const Text("20.0"),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset("images/screw.png"),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => const Inbox());
                    },
                    leading: const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    ),
                    title: const Text(
                      "Spotify",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    subtitle: const Text(
                      "That's awesome!",
                      style: TextStyle(fontSize: 14),
                    ),
                    isThreeLine: true,
                    trailing: SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("20.10"),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset("images/screw.png"),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  "14",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => const Inbox());
                    },
                    leading: const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    ),
                    title: const Text(
                      "Friends Hanging Out",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    subtitle: const Text(
                      "I am hopping for a really a big discount",
                      style: TextStyle(fontSize: 14),
                    ),
                    isThreeLine: true,
                    trailing: Column(
                      children: [
                        const Text("20.0"),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset("images/screw.png"),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(() => const Inbox());
                    },
                    leading: const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person),
                    ),
                    title: const Text(
                      "Spotify",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    subtitle: const Text(
                      "That's awesome!",
                      style: TextStyle(fontSize: 14),
                    ),
                    isThreeLine: true,
                    trailing: SizedBox(
                      width: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("19.38"),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset("images/screw.png"),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  " 4 ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Contents of Tab 2
            Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Spotify",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Image.asset(
                                  "images/solar_verified-check-bold.png"),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const BusinessDetails());
                              },
                              child: Icon(Icons.arrow_forward_ios,
                                  size: 15, color: primaryColor))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            color: Color(0xffF4F6F9),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Theresa Webb",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const Text(
                              "Hello guys, don't forget to update the work that will be done today. May our work be given smooth 😁",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 16),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "20.0",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("images/heart.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset("images/send.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              Image.asset("images/share.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Spotify",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Image.asset(
                                  "images/solar_verified-check-bold.png"),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const BusinessDetails());
                              },
                              child: Icon(Icons.arrow_forward_ios,
                                  size: 15, color: primaryColor))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            color: Color(0xffF4F6F9),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Theresa Webb",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const Text(
                              "Hello guys, don't forget to update the work that will be done today. May our work be given smooth 😁",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 16),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "20.0",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("images/heart.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset("images/send.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              Image.asset("images/share.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 15,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Spotify",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Image.asset(
                                  "images/solar_verified-check-bold.png"),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const BusinessDetails());
                              },
                              child: Icon(Icons.arrow_forward_ios,
                                  size: 15, color: primaryColor))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            color: Color(0xffF4F6F9),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Theresa Webb",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const Text(
                              "Hello guys, don't forget to update the work that will be done today. May our work be given smooth 😁",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 16),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "20.0",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("images/heart.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset("images/send.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              Image.asset("images/share.png"),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "149",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Contents of Tab 3
            Container(
              child: const Center(
                child: Text('Tab 3'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
