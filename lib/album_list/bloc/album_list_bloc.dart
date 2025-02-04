import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_assignment/album_list/domain/album.dart';
import 'package:navatech_assignment/album_list/domain/album_list_use_case.dart';

part 'album_list_event.dart';
part 'album_list_state.dart';

class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  AlbumListBloc({
    required this.albumListUseCase,
  }) : super(const LoadingState()) {
    on<FetchAlbumsList>(_fetchAlbumsList);
  }

  final AlbumListUseCase albumListUseCase;

  Future<void> _fetchAlbumsList(
    FetchAlbumsList event,
    Emitter<AlbumListState> emit,
  ) async {
    emit(const LoadingState());
    final List<Album> albumList = await albumListUseCase.fetchAlbumList();
    emit(AlbumListFetched(albumList));
  }
}
