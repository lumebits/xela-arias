import 'dart:io';

import '../image_repository.dart';
import 'model/models.dart';

abstract class ImageRepository {
  Stream<List<Image>> findImages(int limit,
      [DateTime startAfter, int offset = 0]);

  Future insert(Image image, File file);

  Future delete(String id);

  Future<bool> exists(String id);

  Future initialize();
}
