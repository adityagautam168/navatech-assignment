import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart';
import 'package:navatech_assignment/webservice/network_request.dart';
import 'package:navatech_assignment/webservice/network_request_type.dart';
import 'package:navatech_assignment/webservice/network_response.dart';

class HttpNetworkClient {
  final Client _client = Client();

  Future<NetworkResponse?> constructAndExecuteNetworkRequest<T>({
    required Uri requestUri,
    required NetworkRequestType requestType,
    Map<String, String>? headers,
    Map<String, dynamic>? requestBody,
  }) async {
    final request = constructNetworkRequest(
      requestUri: requestUri,
      requestType: requestType,
      headers: headers,
      requestBody: requestBody,
    );
    return executeNetworkRequest(request);
  }

  NetworkRequest constructNetworkRequest({
    required Uri requestUri,
    required NetworkRequestType requestType,
    Map<String, String>? headers,
    Map<String, dynamic>? requestBody,
  }) {
    return NetworkRequest(
      requestUri: requestUri,
      requestType: requestType,
      headers: headers,
      requestJson: requestBody != null ? jsonEncode(requestBody) : null,
    );
  }

  Future<NetworkResponse?> executeNetworkRequest(
    NetworkRequest request,
  ) async {
    debugPrint('http/request: ${DateTime.now()}\n${request.requestUri}\n${request.headers}\n${request.requestJson}', wrapWidth: 1024);

    late final Response? response;

    switch (request.requestType) {
      case NetworkRequestType.get:
        response = await _client.get(
          request.requestUri,
          headers: request.headers,
        );

      case NetworkRequestType.post:
        response = await _client.post(
          request.requestUri,
          headers: request.headers,
          body: request.requestJson,
        );

      case NetworkRequestType.put:
        response = await _client.put(
          request.requestUri,
          headers: request.headers,
          body: request.requestJson,
        );

      case NetworkRequestType.delete:
        response = await _client.delete(
          request.requestUri,
          headers: request.headers,
          body: request.requestJson,
        );

      case NetworkRequestType.patch:
        response = await _client.patch(
          request.requestUri,
          headers: request.headers,
          body: request.requestJson,
        );

      case NetworkRequestType.head:
        response = await _client.head(
          request.requestUri,
          headers: request.headers,
        );

      default:
        response = null;
    }

    debugPrint('http/response: ${response?.statusCode}\n${request.requestUri}\n${response?.headers}\n${response?.body}', wrapWidth: 1024);

    if (response != null) {
      return NetworkResponse(
        statusCode: response.statusCode,
        responseJson: response.body,
      );
    } else {
      return null;
    }
  }
}
