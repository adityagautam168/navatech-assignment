import 'package:flutter/material.dart';
import 'package:navatech_assignment/album_list/components/infinite_scroll_view.dart';
import 'package:navatech_assignment/album_list/components/photo_widget.dart';
import 'package:navatech_assignment/album_list/domain/album.dart';

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({
    super.key,
    required this.album,
  });

  final Album album;
  double get _photoThumbnailSize => 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        SizedBox(
          height: _photoThumbnailSize,
          child: _buildPhotosList(),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      album.title ?? '',
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildPhotosList() {
    return BidirectionalListView.separated(
      axis: Axis.horizontal,
      anchorPosition: AnchorPosition.start,
      forwardListBuilder: (context, index) {
        return PhotoWidget(
          photo: (album.photoList ?? [])[index % (album.photoList?.length ?? 1)],
        );
      },
      reverseListBuilder: (context, index) {
        return PhotoWidget(
          photo: (album.photoList ?? [])[index % (album.photoList?.length ?? 1)],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 16),
    );
  }
}
