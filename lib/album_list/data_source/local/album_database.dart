import 'dart:async';

import 'package:navatech_assignment/album_list/data_source/local/album_dao.dart';
import 'package:navatech_assignment/core/data_source/local_data_source.dart';
import 'package:sqflite/sqflite.dart';

final class AlbumDatabase extends LocalDatabase<AlbumDao> {
  AlbumDatabase();

  String get _dbPath => 'album.db';
  String get _tableName => 'album';

  String get _idColumn => 'album_id';
  String get _titleColumn => 'title';
  String get _photosListJsonColumn => 'photos_list_json';

  @override
  Future<void> initDatabase() async {
    database = await openDatabase(
      _dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
          $_idColumn INTEGER PRIMARY KEY, 
          $_titleColumn TEXT, 
          $_photosListJsonColumn TEXT
          )
          ''',
        );
      },
    );
  }

  @override
  Future<AlbumDao?> get(int id) async {
    await dbInitCompleter.future;
    try {
      final List<Map<String, Object?>> maps = await database.query(
        _tableName,
        columns: [_idColumn, _titleColumn, _photosListJsonColumn],
        where: '$_idColumn = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return AlbumDao.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<AlbumDao>?> getAll() async {
    await dbInitCompleter.future;
    try {
      final List<Map<String, Object?>> maps = await database.query(_tableName);
      return List.generate(maps.length, (i) => AlbumDao.fromMap(maps[i]));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> insert(AlbumDao entry) async {
    await dbInitCompleter.future;
    await database.insert(
      _tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> batchInsert(List<AlbumDao> entries) async {
    await dbInitCompleter.future;
    final Batch batch = database.batch();
    for (final AlbumDao entry in entries) {
      batch.insert(
        _tableName,
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<void> update(AlbumDao entry) async {
    await dbInitCompleter.future;
    await database.update(
      _tableName,
      entry.toMap(),
      where: '$_idColumn = ?',
      whereArgs: [entry.albumId],
    );
  }

  @override
  Future<void> delete(AlbumDao entry) async {
    await dbInitCompleter.future;
    await database.delete(
      _tableName,
      where: '$_idColumn = ?',
      whereArgs: [entry.albumId],
    );
  }
}
