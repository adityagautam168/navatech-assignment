import 'dart:convert';

import 'package:navatech_assignment/album_list/models/album_dto.dart';
import 'package:navatech_assignment/constants/string_constants.dart';
import 'package:navatech_assignment/webservice/http_network_client.dart';
import 'package:navatech_assignment/webservice/network_request_type.dart';

abstract class AlbumRepository {
  Future<List<AlbumDTO>?> fetchAlbumList();
}

class AlbumRepositoryImpl extends AlbumRepository {

  @override
  Future<List<AlbumDTO>?> fetchAlbumList() async {
    final client = HttpNetworkClient();
    final response = await client.constructAndExecuteNetworkRequest(
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
}
