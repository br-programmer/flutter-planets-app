import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlanetsImage extends StatelessWidget {
  const PlanetsImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });
  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final encodedUrl = Uri.encodeComponent(imageUrl);
    const baseUrl = String.fromEnvironment('baseUrl');
    final proxyUrl = '${baseUrl}image-proxy?url=$encodedUrl';
    return CachedNetworkImage(
      imageUrl: proxyUrl,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
