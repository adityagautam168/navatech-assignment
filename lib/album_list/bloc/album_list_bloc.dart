import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_assignment/album_list/domain/album.dart';
import 'package:navatech_assignment/album_list/repository/album_repository.dart';

part 'album_list_event.dart';
part 'album_list_state.dart';

class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  AlbumListBloc({
    required this.albumRepository,
  }) : super(const LoadingState()) {
    on<FetchAlbumsList>(_fetchAlbumsList);
  }

  final AlbumRepository albumRepository;

  Future<void> _fetchAlbumsList(
    FetchAlbumsList event,
    Emitter<AlbumListState> emit,
  ) async {
    emit(const LoadingState());
    final List<Album> albumList = await albumRepository.fetchAlbumList() ?? [];
    emit(AlbumListFetched(albumList));
  }
}
