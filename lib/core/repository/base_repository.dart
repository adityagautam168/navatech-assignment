import 'package:navatech_assignment/core/data_source/local_data_source.dart';
import 'package:navatech_assignment/core/data_source/network_data_source.dart';

abstract class BaseRepository<T extends DataTransferObject, R extends DataAccessObject> {
  const BaseRepository({
    this.networkDataSource,
    this.localDataSource,
  });

  final NetworkDataSource<T>? networkDataSource;
  final LocalDataSource<R>? localDataSource;
}
