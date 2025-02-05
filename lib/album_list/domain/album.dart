import 'package:json_annotation/json_annotation.dart';
import 'package:navatech_assignment/album_list/domain/photo.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  const Album({
    required this.id,
    required this.title,
    required this.photoList,
  });

  final int? id;
  final String? title;
  final List<Photo>? photoList;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
