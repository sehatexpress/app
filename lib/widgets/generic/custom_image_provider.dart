import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loader_widget.dart';

class CustomImageProvider extends StatelessWidget {
  final String image;
  const CustomImageProvider({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: LoaderWidget(
            progress: downloadProgress.progress,
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
