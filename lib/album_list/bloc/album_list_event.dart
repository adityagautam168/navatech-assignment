part of 'album_list_bloc.dart';

sealed class AlbumListEvent {
  const AlbumListEvent();
}

class FetchAlbumsList extends AlbumListEvent {
  const FetchAlbumsList();
}
