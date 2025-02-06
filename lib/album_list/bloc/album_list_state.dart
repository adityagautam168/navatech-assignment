part of 'album_list_bloc.dart';

sealed class AlbumListState {
  const AlbumListState();
}

final class LoadingState extends AlbumListState {
  const LoadingState();
}

final class AlbumListFetched extends AlbumListState {
  const AlbumListFetched(this.albumList);

  final List<Album> albumList;
}

final class NoNetworkExceptionState extends AlbumListState {
  const NoNetworkExceptionState(this.displayMessage);

  final String displayMessage;
}

final class UnknownExceptionState extends AlbumListState {
  const UnknownExceptionState(this.displayMessage);

  final String displayMessage;
}
