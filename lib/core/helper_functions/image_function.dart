import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HelperFunctions {
  // i need make method to check svg or network image

  static Widget checkImageSvfOrNot(String image) {
    return image.endsWith(".svg")
        ? SvgPicture.network(
      image,
      height: 24,
      width: 24,
    )
        : CachedNetworkImage(
      imageUrl: image,
      errorWidget: (c, d, e) {
        return const Icon(Icons.error);
      },
      height: 24,
      width: 24,
    );
  }
}
