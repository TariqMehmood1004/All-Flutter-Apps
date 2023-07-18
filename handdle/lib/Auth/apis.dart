import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class APIs {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User get currentUser => auth.currentUser!;
  static Size size(BuildContext context) => MediaQuery.of(context).size;

  static String chooseFirstTwoWords(String word) {
    List<String> words = word.split(' ');
    return words.length > 2 ? words.sublist(0, 2).join(' ') : word;
  }

  static String chooseToSplitWords(String word, int length) {
    List<String> words = word.split(' ');
    List<String> selectedWords;
    if (words.length > length) {
      if (words.length > 10) {
        selectedWords = words.sublist(0, 2);
      } else {
        selectedWords = words.sublist(0, length);
      }
      return '${selectedWords.join(' ')}...';
    } else {
      return word;
    }
  }

  static Widget cachedNetworkImage2({
    required String imageUrl,
    BuildContext? context,
    bool isOnline = false,
  }) {
    return Stack(
      children: [
        ClipRRect(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundColor: primaryColor,
              foregroundColor: primaryColor,
              backgroundImage: imageProvider,
              radius: 23.5,
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor: primaryColor,
              foregroundColor: primaryColor,
              radius: 23.5,
              child: const Icon(Icons.person),
            ),
          ),
        ),
        if (isOnline)
          Positioned(
            top: 0,
            left: 0,
            width: 47,
            height: 47,
            child: ClipRRect(
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color(0XFFF96666),
                      width: 3,
                    )),
                child: const Icon(
                  Icons.done,
                  color: Colors.black,
                  size: 8,
                ),
              ),
            ),
          ),
      ],
    );
  }

  static Widget cachedNetworkImage({
    required String imageUrl,
    BuildContext? context,
    bool isOnline = false,
    double radius = 23.5,
  }) {
    return Stack(
      children: [
        ClipRRect(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundColor: primaryColor,
              foregroundColor: primaryColor,
              backgroundImage: imageProvider,
              radius: radius,
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor: primaryColor,
              foregroundColor: primaryColor,
              radius: radius,
              child: const Icon(Icons.person),
            ),
          ),
        ),
        isOnline
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: const Color(0xffF4E04D),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.done_all,
                    color: Colors.black,
                    size: 10,
                  ),
                ),
              )
            : Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: const Color(0xffF4E04D),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text("x", style: TextStyle(
                    fontSize: 10,
                  ),),
                ),
              )
      ],
    );
  }

  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    // if time is not available then return below statement.
    if (i == -1) return 'Last seen not available!';

    DateTime time = DateTime.fromMicrosecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    // String formattedTime =
    //     TimeOfDay.fromDateTime(time.toLocal()).format(context);

    String formattedTime = DateFormat.jm().format(time.toLocal());

    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = _getMonth(time);
    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';

      case 2:
        return 'Feb';

      case 3:
        return 'Mar';

      case 4:
        return 'Apr';

      case 5:
        return 'May';

      case 6:
        return 'Jun';

      case 7:
        return 'Jul';

      case 8:
        return 'Aug';

      case 9:
        return 'Sep';

      case 10:
        return 'Oct';

      case 11:
        return 'Nov';

      case 12:
        return 'Dec';

      default:
        return 'NA';
    }
  }
}
