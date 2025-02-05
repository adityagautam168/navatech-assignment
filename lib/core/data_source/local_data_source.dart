import 'dart:async';

import 'package:sqflite/sqlite_api.dart';

abstract class LocalDataSource<T extends DataAccessObject> {
  const LocalDataSource(this.database);

  final LocalDatabase<T> database;
}

abstract base class LocalDatabase<T extends DataAccessObject> {
  LocalDatabase() {
    dbInitCompleter.complete(initDatabase());
  }

  late final Database database;
  final Completer<void> dbInitCompleter = Completer();

  Future<void> initDatabase();

  Future<T?> get(int id);
  Future<List<T>?> getAll();
  Future<void> insert(T entry);
  Future<void> update(T entry);
  Future<void> delete(T entry);
}

abstract class DataAccessObject {
  const DataAccessObject();

  DataAccessObject.fromMap(Map<String, Object?> map);

  Map<String, Object?> toMap();
}
