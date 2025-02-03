import 'package:flutter/material.dart';
import 'package:navatech_assignment/components/album_widget.dart';
import 'package:navatech_assignment/components/infinite_scroll_view.dart';
import 'package:navatech_assignment/models/album.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 24,
        ),
        child: BidirectionalListView.separated(
          // center: ColoredBox(color: Colors.red, child: Text('data'),),
          forwardListBuilder: (context, index) {
            return AlbumWidget(
              album: Album(
                userId: 1,
                id: 1,
                title: 'quidem molestiae enim',
              ),
            );
          },
          reverseListBuilder: (context, index) {
            return AlbumWidget(
              album: Album(
                userId: 1,
                id: 1,
                title: 'quidem molestiae enim',
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
