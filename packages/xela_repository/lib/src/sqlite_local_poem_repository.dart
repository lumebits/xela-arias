import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../poem_repository.dart';
import 'entity/entities.dart';

final String poemTable = 'poem';
final String columnId = 'id';
final String columnText = 'text';

class SqliteLocalPoemRepository implements PoemRepository {
  static final SqliteLocalPoemRepository _sqliteLocalPoemRepository =
  SqliteLocalPoemRepository._internal();

  SqliteLocalPoemRepository._internal();

  factory SqliteLocalPoemRepository() {
    return _sqliteLocalPoemRepository;
  }

  Database db;

  @override
  Future initialize() async {
    this.db = db ??
        await openDatabase('xela-arias.db', version: 1,
            onCreate: (Database db, int version) async {
              await db.execute('''
          create table $poemTable ( 
            $columnId text primary key, 
            $columnText text not null)
          ''');
            });
  }

  @override
  Stream<List<Poem>> findPoems(int limit,
      [DateTime startAfter, int offset = 0]) {
    return db
        .query(poemTable,
        distinct: true, orderBy: columnId, limit: limit, offset: offset)
        .asStream()
        .map((poems) {
      return poems
          .map((poem) =>
          Poem.fromEntity(PoemEntity.fromJson(poem)))
          .toList();
    });
  }

  @override
  Future insert(Poem poem) async {
    await db.insert(poemTable, <String, dynamic>{
      columnId: poem.id,
      columnText: poem.text
    });
  }

  @override
  Future delete(String id) async {
    await db.delete(poemTable, where: '$columnId = ?', whereArgs: [id]);
  }

  @override
  Future<bool> exists(String id) async {
    var queryResult =
    await db.query(poemTable, where: '$columnId = ?', whereArgs: [id]);
    return queryResult.isNotEmpty;
  }
}
