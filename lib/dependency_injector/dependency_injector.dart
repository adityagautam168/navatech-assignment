import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:navatech_assignment/album_list/data_source/local/album_cache.dart';
import 'package:navatech_assignment/album_list/data_source/local/album_database.dart';
import 'package:navatech_assignment/album_list/data_source/network/album_network_source.dart';
import 'package:navatech_assignment/album_list/repository/album_repository.dart';
import 'package:navatech_assignment/core/webservice/http_network_client.dart';

class DependencyInjector {
  factory DependencyInjector() {
    if (_instance == null) {
      _instance = DependencyInjector._(Injector());
      _instance?._mapAllDependencies();
    }
    return _instance!;
  }

  const DependencyInjector._(this._injector);

  final Injector _injector;
  static DependencyInjector? _instance;

  T get<T>() => _injector.get<T>();

  void _mapDependency<T>({
    required T object,
    bool isSingleton = false,
  }) {
    _injector.map<T>((injector) => object, isSingleton: isSingleton);
  }

  void _mapAllDependencies() {
    _mapDependency<HttpNetworkClient>(
      object: HttpNetworkClient(),
      isSingleton: true,
    );

    _mapDependency<AlbumCacheStore>(
      object: AlbumCacheStore(AlbumDatabase()),
      isSingleton: true,
    );

    _mapDependency<AlbumNetworkSource>(
      object: AlbumNetworkSource(get<HttpNetworkClient>()),
    );

    _mapDependency<AlbumRepository>(
      object: AlbumRepositoryImpl(
        albumNetworkSource: get<AlbumNetworkSource>(),
        albumCacheStore: get<AlbumCacheStore>(),
      ),
    );
  }
}
