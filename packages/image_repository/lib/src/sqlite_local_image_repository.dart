import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';

import '../image_repository.dart';
import 'entity/entities.dart';

final String imageTable = 'image';
final String columnId = 'id';
final String columnUrl = 'url';

class SqliteLocalImageRepository implements ImageRepository {
  static final SqliteLocalImageRepository _sqliteLocalImageRepository =
  SqliteLocalImageRepository._internal();

  SqliteLocalImageRepository._internal();

  factory SqliteLocalImageRepository() {
    return _sqliteLocalImageRepository;
  }

  Database db;

  @override
  Future initialize() async {
    this.db = db ??
        await openDatabase('xela-arias.db', version: 1,
            onCreate: (Database db, int version) async {
              await db.execute('''
          create table $imageTable ( 
            $columnId url primary key, 
            $columnUrl url not null)
          ''');
            });
  }

  @override
  Stream<List<Image>> findImages(int limit,
      [DateTime startAfter, int offset = 0]) {
    return db
        .query(imageTable,
        distinct: true, orderBy: columnId, limit: limit, offset: offset)
        .asStream()
        .map((images) {
      return images
          .map((image) =>
          Image.fromEntity(ImageEntity.fromJson(image)))
          .toList();
    });
  }

  @override
  Future insert(Image image, File imageFile) async {
    await db.insert(imageTable, <String, dynamic>{
      columnId: image.id,
      columnUrl: image.url
    });
  }

  @override
  Future delete(String id) async {
    await db.delete(imageTable, where: '$columnId = ?', whereArgs: [id]);
  }

  @override
  Future<bool> exists(String id) async {
    var queryResult =
    await db.query(imageTable, where: '$columnId = ?', whereArgs: [id]);
    return queryResult.isNotEmpty;
  }
}
