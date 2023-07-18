
import 'package:flutter/material.dart';
import 'package:notes/colors/colors.dart';

import '../Model/notes_model.dart';

class MyNotesContainer extends StatelessWidget {
  const MyNotesContainer({
    super.key,
    required String dateTime,
    required this.title,
    required this.description,
    this.imageUrl = "assets/images/tetris.png",
    required this.onTap,
    required this.onLongPressed,
  }) : _dateTime = dateTime;

  final String _dateTime;
  final String title;
  final String description;
  final String imageUrl;
  final void Function() onTap;
  final void Function() onLongPressed;



  @override
  Widget build(BuildContext context) {

    final List<NotesModel> notesList = [
      NotesModel(
        title: title,
        description: description,
        dateTime: _dateTime,
        imageUrl: imageUrl,
      ),
    ];

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: AppColors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: AppColors.yellowRGBA,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: InkWell(
                  onTap: onTap,
                  onLongPress: onLongPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notesList[0].title.toString().toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: "Arial",
                                  ),
                                ),
                                Text(
                                  notesList[0].description ?? "No description available",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  notesList[0].dateTime.toString(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: 80,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.transparent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image(
                              image: AssetImage(notesList[0].imageUrl.toString()),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
