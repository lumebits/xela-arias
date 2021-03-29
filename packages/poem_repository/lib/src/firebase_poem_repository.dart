import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../poem_repository.dart';
import 'entity/entities.dart';

final poemsCollection = FirebaseFirestore.instance.collection('poems');

class FirebasePoemRepository implements PoemRepository {
  static final FirebasePoemRepository _firebasePoemRepository =
  FirebasePoemRepository._internal();

  FirebasePoemRepository._internal();

  factory FirebasePoemRepository() {
    return _firebasePoemRepository;
  }

  @override
  Future initialize() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  }

  @override
  Stream<List<Poem>> findPoems(int limit,
      [DateTime startAfter, int offset]) {
    var refPoems = poemsCollection.orderBy('date', descending: true).limit(limit);

    if (startAfter != null) {
      refPoems = refPoems.startAfter([startAfter]);
    }

    return refPoems.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Poem.fromEntity(PoemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future insert(Poem poem) {
    throw UnimplementedError();
  }

  @override
  Future delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> exists(String id) {
    throw UnimplementedError();
  }
}
