import 'dart:typed_data';

import '../pair_repository.dart';
import 'model/models.dart';

abstract class PairRepository {
  Stream<List<Pair>> findPairs(int limit,
      [DateTime startAfter, int offset = 0]);

  Future insert(Pair pair, {Uint8List image, String name});

  Future delete(String id);

  Future<bool> exists(String id);

  Future initialize();
}
