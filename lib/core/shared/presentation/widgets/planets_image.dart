import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
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

  String get proxyImageUrl {
    final encodedUrl = Uri.encodeComponent(imageUrl);
    const baseUrl = String.fromEnvironment('baseUrl');
    return '${baseUrl}image-proxy?url=$encodedUrl';
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: switch (kIsWeb) { true => proxyImageUrl, false => imageUrl },
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
