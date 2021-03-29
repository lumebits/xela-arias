import 'model/models.dart';

abstract class PoemRepository {
  Stream<List<Poem>> findPoems(int limit,
      [DateTime startAfter, int offset = 0]);

  Future insert(Poem poem);

  Future delete(String id);

  Future<bool> exists(String id);

  Future initialize();
}
