import 'package:json_annotation/json_annotation.dart';

part 'photo_dto.g.dart';

@JsonSerializable()
class PhotoDTO {
  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  const PhotoDTO({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory PhotoDTO.fromJson(Map<String, dynamic> json) => _$PhotoDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoDTOToJson(this);
}
