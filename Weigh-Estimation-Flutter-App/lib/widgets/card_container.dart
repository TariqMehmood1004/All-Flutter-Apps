
import 'package:flutter/material.dart';
import '../colors/colors.dart';

class MyCardContainer extends StatelessWidget {
  const MyCardContainer({
    super.key,
    required this.title,
    this.imageUrl = "",
    required this.onTap,
  });

  final String title;
  final String? imageUrl;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        child: InkResponse(
          onTap: onTap,
          highlightShape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.0),
          containedInkWell: true,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    imageUrl!,
                    width: 80,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}

class MyCardContainerWithoutImage extends StatelessWidget {
  const MyCardContainerWithoutImage({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        child: InkResponse(
          onTap: onTap,
          highlightShape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.0),
          containedInkWell: true,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "OpenSans",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
