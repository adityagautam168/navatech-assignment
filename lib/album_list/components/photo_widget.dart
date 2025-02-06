import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navatech_assignment/album_list/domain/photo.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.photo,
  });

  final Photo photo;
  double get _photoThumbnailSize => 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          height: _photoThumbnailSize,
          width: _photoThumbnailSize,
          imageUrl: photo.thumbnailUrl ?? '',
          placeholder: (context, url) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            );
          },
        ),
        const SizedBox(height: 4),
        Text(
          photo.id?.toString() ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
