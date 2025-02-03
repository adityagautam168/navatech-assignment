import 'package:flutter/material.dart';
import 'package:navatech_assignment/components/infinite_scroll_view.dart';
import 'package:navatech_assignment/components/photo_widget.dart';
import 'package:navatech_assignment/models/album.dart';
import 'package:navatech_assignment/models/photo.dart';

class AlbumWidget extends StatelessWidget {
  const AlbumWidget({
    super.key,
    required this.album,
  });

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        SizedBox(
          height: 50,
          child: BidirectionalListView.separated(
            axis: Axis.horizontal,
            anchorPosition: AnchorPosition.start,
            forwardListBuilder: (context, index) {
              return PhotoWidget(
                photo: Photo(
                  albumId: 1,
                  id: 1,
                  title: 'accusamus beatae ad facilis cum similique qui sunt',
                  url: 'https://place-hold.it/150/92c952&text=$index',
                  thumbnailUrl: 'https://place-hold.it/150/92c952&text=$index',
                ),
              );
            },
            reverseListBuilder: (context, index) {
              return PhotoWidget(
                photo: Photo(
                  albumId: 1,
                  id: 1,
                  title: 'accusamus beatae ad facilis cum similique qui sunt',
                  url: 'https://place-hold.it/150/92c952&text=$index',
                  thumbnailUrl: 'https://place-hold.it/150/92c952&text=$index',
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      album.title ?? '',
      style: TextStyle(color: Colors.black),
    );
  }
}
