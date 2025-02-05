import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_assignment/album_list/bloc/album_list_bloc.dart';
import 'package:navatech_assignment/album_list/components/album_placeholder_widget.dart';
import 'package:navatech_assignment/album_list/components/album_widget.dart';
import 'package:navatech_assignment/album_list/components/infinite_scroll_view.dart';
import 'package:navatech_assignment/generated/l10n.dart';

class AlbumListRoute extends StatelessWidget {
  const AlbumListRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).albumListTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 24,
        ),
        child: _buildAlbumList(),
      ),
    );
  }

  Widget _buildAlbumList() {
    return BlocBuilder<AlbumListBloc, AlbumListState>(
      buildWhen: (previous, current) => current is AlbumListFetched,
      builder: (context, state) {
        if (state is AlbumListFetched) {
          return BidirectionalListView.separated(
            anchorPosition: AnchorPosition.start,
            forwardListBuilder: (context, index) {
              return AlbumWidget(
                album: state.albumList[index % state.albumList.length],
              );
            },
            reverseListBuilder: (context, index) {
              final int length = state.albumList.length;
              final int lastIndex = length - 1;
              return AlbumWidget(
                album: state.albumList[lastIndex - (index % length)],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        } else {
          return const FullScreenLoaderWidget();
        }
      },
    );
  }
}
