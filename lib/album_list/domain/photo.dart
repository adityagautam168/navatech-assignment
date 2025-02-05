import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  const Photo({
    required this.id,
    required this.url,
    required this.thumbnailUrl,
  });

  final int? id;
  final String? url;
  final String? thumbnailUrl;

  // factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  factory Photo.fromJson(Map<String, dynamic> json) {
    /*
    TODO(Aditya): This is a temporary workaround since the original URL
     does not work. Replacing it with an alternate placeholder service as of now.
    */
    return Photo(
      id: json['id'] as int?,
      url: (json['url'] as String?)?..replaceAll(
        'via.placeholder.com',
        'place-hold.it',
      ),
      thumbnailUrl: (json['thumbnailUrl'] as String?)?.replaceAll(
        'via.placeholder.com',
        'place-hold.it',
      ),
    );
  }

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
