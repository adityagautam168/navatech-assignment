import 'package:navatech_assignment/album_list/domain/photo.dart';

class Album {
  const Album({
    required this.id,
    required this.title,
    required this.photoList,
  });

  final int? id;
  final String? title;
  final List<Photo>? photoList;
}
