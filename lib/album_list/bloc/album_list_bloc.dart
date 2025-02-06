import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_assignment/album_list/domain/album.dart';
import 'package:navatech_assignment/album_list/repository/album_repository.dart';
import 'package:navatech_assignment/generated/l10n.dart';

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
    await _tryBlock(
      emit,
      () async {
        emit(const LoadingState());
        final List<Album> albumList = await albumRepository.fetchAlbumList() ?? [];
        emit(AlbumListFetched(albumList));
      },
    );
  }

  Future<void> _tryBlock(
    Emitter<AlbumListState> emit,
    Function() function,
  ) async {
    try {
      await function();
    } on SocketException catch (_) {
      emit(NoNetworkExceptionState(Strings.current.noInternetConnectionError));
    } on TimeoutException catch (_) {
      emit(UnknownExceptionState(Strings.current.requestTimedOutError));
    } catch (_) {
      emit(UnknownExceptionState(Strings.current.unknownError));
    }
  }
}
