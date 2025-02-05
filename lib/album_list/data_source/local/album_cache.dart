import 'package:navatech_assignment/album_list/data_source/local/album_dao.dart';
import 'package:navatech_assignment/album_list/data_source/local/album_database.dart';
import 'package:navatech_assignment/core/data_source/local_data_source.dart';

class AlbumCacheStore extends LocalDataSource<AlbumDao> {
  AlbumCacheStore(this.albumDatabase) : super(albumDatabase);

  final AlbumDatabase albumDatabase;
}
