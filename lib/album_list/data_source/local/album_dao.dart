import 'package:navatech_assignment/core/data_source/local_data_source.dart';

class AlbumDao extends DataAccessObject {
  const AlbumDao({
    required this.albumId,
    required this.title,
    required this.photosListJson,
  });

  final int? albumId;
  final String? title;
  final String? photosListJson;


  factory AlbumDao.fromMap(Map<String, Object?> map) {
    return AlbumDao(
      albumId: map['album_id'] as int?,
      title: map['title'] as String?,
      photosListJson: map['photos_list_json'] as String?,
    );
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'album_id': albumId,
      'title': title,
      'photos_list_json': photosListJson,
    };
  }
}
