import 'package:navatech_assignment/album_list/domain/album.dart';
import 'package:navatech_assignment/album_list/domain/photo.dart';
import 'package:navatech_assignment/album_list/models/album_dto.dart';
import 'package:navatech_assignment/album_list/models/photo_dto.dart';
import 'package:navatech_assignment/album_list/repository/album_repository.dart';
import 'package:navatech_assignment/album_list/repository/photo_repository.dart';

class AlbumListUseCase {
  const AlbumListUseCase({
    required this.albumRepository,
    required this.photoRepository,
  });

  final AlbumRepository albumRepository;
  final PhotoRepository photoRepository;

  Future<List<Album>> fetchAlbumList() async {
    final List<AlbumDTO> albumListResponse =
        await albumRepository.fetchAlbumList() ?? [];
    final List<Album> albumList = [];

    for (final album in albumListResponse) {
      if (album.id == null) continue;
      final List<PhotoDTO> photoListResponse =
          await photoRepository.fetchPhotoList(album.id!) ?? [];

      albumList.add(
        Album(
          id: album.id,
          title: album.title,
          photoList: photoListResponse.map<Photo>(
            (e) {
              return Photo(
                /*
                TODO(Aditya): This is a temporary workaround since the original URL
                 does not work. Replacing it with an alternate placeholder service as of now.
                */
                url: e.url?.replaceAll(
                  'via.placeholder.com',
                  'place-hold.it',
                ),
                thumbnailUrl: e.thumbnailUrl?.replaceAll(
                  'via.placeholder.com',
                  'place-hold.it',
                ),
              );
            },
          ).toList(growable: false),
        ),
      );
    }

    return albumList;
  }
}