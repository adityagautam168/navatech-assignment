class NetworkResponse {
  const NetworkResponse({
    required this.statusCode,
    required this.responseJson,
  });

  final int statusCode;
  final String? responseJson;
}
