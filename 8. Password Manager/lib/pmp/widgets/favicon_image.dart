// ignore_for_file: deprecated_member_use

import 'package:app/common/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavIconImage extends StatelessWidget {
  final String address;
  final double width;

  const FavIconImage({
    Key? key,
    required this.address,
    this.width = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = address;
    SvgPicture placeholder = SvgPicture.asset(
      logoCircleSvg,
      color: Colors.white,
      width: width,
    );
    url = url.replaceFirst(RegExp('https://|http://'), '');
    String request = 'https://api.faviconkit.com/$url/256';

    return CachedNetworkImage(
      imageUrl: request,
      placeholder: (context, url) => placeholder,
      errorWidget: (ctx, obj, s) => placeholder,
      width: width,
      fit: BoxFit.fill,
    );
  }
}
