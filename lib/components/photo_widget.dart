import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navatech_assignment/models/photo.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photo.thumbnailUrl ?? '',
    );
  }
}
