import 'package:navatech_assignment/core/webservice/http_network_client.dart';

abstract class NetworkDataSource<T extends DataTransferObject> {
  const NetworkDataSource(this.networkClient);

  final HttpNetworkClient networkClient;
}

abstract class DataTransferObject {
  const DataTransferObject();
}
