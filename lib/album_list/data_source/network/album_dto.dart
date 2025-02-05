import 'package:json_annotation/json_annotation.dart';
import 'package:navatech_assignment/core/data_source/network_data_source.dart';

part 'album_dto.g.dart';

@JsonSerializable()
class AlbumDTO extends DataTransferObject {
  const AlbumDTO({
    this.userId,
    this.id,
    this.title,
  });

  final int? userId;
  final int? id;
  final String? title;

  factory AlbumDTO.fromJson(Map<String, dynamic> json) => _$AlbumDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDTOToJson(this);
}
