import 'package:flutter/material.dart';
import 'package:navatech_assignment/album_list/components/infinite_scroll_view.dart';
import 'package:navatech_assignment/album_list/components/photo_widget.dart';
import 'package:navatech_assignment/album_list/domain/album.dart';
import 'package:navatech_assignment/generated/l10n.dart';

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({
    super.key,
    required this.album,
  });

  final Album album;
  double get _photoThumbnailSize => 70;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        const SizedBox(height: 8),
        SizedBox(
          height: _photoThumbnailSize,
          child: _buildPhotosList(),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      Strings.of(context).albumTitle(album.id?.toString() ?? ''),
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
        final int? length = album.photoList?.length;
        final int? lastIndex = length != null ? length - 1 : null;
        return PhotoWidget(
          photo: (album.photoList ?? [])[
            (lastIndex ?? index) - (index % (length ?? 1))
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 16),
    );
  }
}
