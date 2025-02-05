import 'package:navatech_assignment/core/webservice/network_request_type.dart';

class NetworkRequest {
  const NetworkRequest({
    required this.requestUri,
    required this.requestType,
    required this.headers,
    required this.requestJson,
  });

  final Uri requestUri;
  final NetworkRequestType requestType;
  final Map<String, String>? headers;
  final String? requestJson;
}
