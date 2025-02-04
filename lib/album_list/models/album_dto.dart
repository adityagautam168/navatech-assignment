import 'package:json_annotation/json_annotation.dart';

part 'album_dto.g.dart';

@JsonSerializable()
class AlbumDTO {
  final int? userId;
  final int? id;
  final String? title;

  const AlbumDTO({
    this.userId,
    this.id,
    this.title,
  });

  factory AlbumDTO.fromJson(Map<String, dynamic> json) => _$AlbumDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDTOToJson(this);
}
