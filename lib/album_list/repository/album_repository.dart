import 'dart:convert';

import 'package:navatech_assignment/album_list/data_source/local/album_cache.dart';
import 'package:navatech_assignment/album_list/data_source/local/album_dao.dart';
import 'package:navatech_assignment/album_list/data_source/network/album_dto.dart';
import 'package:navatech_assignment/album_list/data_source/network/album_network_source.dart';
import 'package:navatech_assignment/album_list/domain/album.dart';
import 'package:navatech_assignment/album_list/domain/photo.dart';
import 'package:navatech_assignment/album_list/models/photo_dto.dart';
import 'package:navatech_assignment/core/repository/base_repository.dart';

abstract class AlbumRepository extends BaseRepository<AlbumDTO, AlbumDao> {
  const AlbumRepository({
    required this.albumNetworkSource,
    required this.albumCacheStore,
  }) : super(
          networkDataSource: albumNetworkSource,
          localDataSource: albumCacheStore,
        );

  final AlbumNetworkSource albumNetworkSource;
  final AlbumCacheStore albumCacheStore;

  Future<List<Album>?> fetchAlbumList();
}

class AlbumRepositoryImpl extends AlbumRepository {
  const AlbumRepositoryImpl({
    required super.albumNetworkSource,
    required super.albumCacheStore,
  });

  @override
  Future<List<Album>?> fetchAlbumList() async {
    // Check cache availability
    final List<AlbumDao>? cachedResponse = await _getAlbumListFromCache();
    // Fetch from cache if present
    if (cachedResponse != null && cachedResponse.isNotEmpty) {
      return cachedResponse.map<Album>(
        (e) {
          return Album(
            id: e.albumId,
            title: e.title,
            photoList: (jsonDecode(e.photosListJson ?? '[]') as List<dynamic>?)
                ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
        },
      ).toList(growable: false);
    }

    // Fetch from network if cache not present
    final albumListResponse = await _fetchAlbumsFromNetwork();
    if (albumListResponse != null) {
      final List<Future<Album?>> taskList = [];
      for (final albumDto in albumListResponse) {
        taskList.add(_createAlbum(albumDto));
      }
      final List<Album> albumList = [];
      final responseList = await Future.wait(
        taskList,
        cleanUp: (album) {
          if (album != null) albumList.add(album);
        },
      );
      albumList.addAll(responseList.nonNulls);

      // Insert into cache
      await _batchInsertIntoDatabase(albumList);

      return albumList;
    }
    return null;
  }

  Future<List<AlbumDTO>?> _fetchAlbumsFromNetwork() async {
    return albumNetworkSource.fetchAlbumList();
  }

  Future<List<PhotoDTO>?> _fetchPhotosFromNetwork(
    int albumId,
  ) async {
    return albumNetworkSource.fetchPhotoList(albumId);
  }

  Future<Album?> _createAlbum(AlbumDTO albumDto) async {
    if (albumDto.id == null) return null;
    final List<PhotoDTO>? photoListResponse =
    await _fetchPhotosFromNetwork(albumDto.id!);
    return Album(
      id: albumDto.id,
      title: albumDto.title,
      photoList: photoListResponse
          ?.map<Photo>(
            (e) => Photo.fromJson(e.toJson()),
      ).toList(),
    );
  }

  Future<void> _batchInsertIntoDatabase(List<Album> albums) {
    return albumCacheStore.albumDatabase.batchInsert(
      albums.map<AlbumDao>(
        (album) {
          return AlbumDao(
            albumId: album.id,
            title: album.title,
            photosListJson: jsonEncode(album.photoList),
          );
        },
      ).toList(growable: false),
    );
  }

  Future<List<AlbumDao>?> _getAlbumListFromCache() async {
    return albumCacheStore.albumDatabase.getAll();
  }
}
