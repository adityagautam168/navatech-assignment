import 'dart:convert';

import 'package:navatech_assignment/album_list/models/photo_dto.dart';
import 'package:navatech_assignment/constants/string_constants.dart';
import 'package:navatech_assignment/webservice/http_network_client.dart';
import 'package:navatech_assignment/webservice/network_request_type.dart';

abstract class PhotoRepository {
  Future<List<PhotoDTO>?> fetchPhotoList(int albumId);
}

class PhotoRepositoryImpl extends PhotoRepository {

  @override
  Future<List<PhotoDTO>?> fetchPhotoList(int albumId) async {
    final client = HttpNetworkClient();
    final response = await client.constructAndExecuteNetworkRequest(
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
