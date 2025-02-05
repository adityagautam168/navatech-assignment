import 'dart:convert';

import 'package:navatech_assignment/album_list/data_source/network/album_dto.dart';
import 'package:navatech_assignment/album_list/models/photo_dto.dart';
import 'package:navatech_assignment/constants/string_constants.dart';
import 'package:navatech_assignment/core/data_source/network_data_source.dart';
import 'package:navatech_assignment/core/webservice/network_request_type.dart';

class AlbumNetworkSource extends NetworkDataSource<AlbumDTO> {
  AlbumNetworkSource(super.networkClient);

  Future<List<AlbumDTO>?> fetchAlbumList() async {
    final response = await networkClient.constructAndExecuteNetworkRequest(
      requestUri: Uri.parse(
        '${StringConstants.baseUrl}${ApiEndpoints.albumsList}',
      ),
      requestType: NetworkRequestType.get,
    );
    if (response != null && response.responseJson != null) {
      final albumListResponse =
          jsonDecode(response.responseJson!) as List<dynamic>?;
      return albumListResponse
          ?.map((e) => AlbumDTO.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    } else {
      return null;
    }
  }

  Future<List<PhotoDTO>?> fetchPhotoList(
    int albumId,
  ) async {
    final response = await networkClient.constructAndExecuteNetworkRequest(
      requestUri: Uri.parse(
        '${StringConstants.baseUrl}${ApiEndpoints.photosList(albumId)}',
      ),
      requestType: NetworkRequestType.get,
    );
    if (response != null && response.responseJson != null) {
      final photoListResponse =
          jsonDecode(response.responseJson!) as List<dynamic>?;
      return photoListResponse
            ?.map((e) => PhotoDTO.fromJson(e as Map<String, dynamic>))
            .toList(growable: false);
    } else {
      return null;
    }
  }
}
