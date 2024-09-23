import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? url;
  final double width, height;

  const CachedImage(
      {super.key,
      required this.url,
      required this.width,
      required this.height});

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: url ?? '',
        imageBuilder: (context, imageProvider) => _imageWidget(imageProvider),
        placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
        errorWidget: (context, url, error) => _imageWidget(
              const AssetImage('assets/images/noimg.png'),
            ));
  }
}
