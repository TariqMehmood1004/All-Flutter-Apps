// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../business/business_details.dart';
import '../../utils/colors.dart';

class FollowingHomePage extends StatefulWidget {
  const FollowingHomePage({super.key});

  @override
  State<FollowingHomePage> createState() => _FollowingHomePageState();
}

class _FollowingHomePageState extends State<FollowingHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Padding(
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
                        Image.asset("images/solar_verified-check-bold.png"),
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
                        Image.asset("images/solar_verified-check-bold.png"),
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
    );
  }
}
