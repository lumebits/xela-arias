import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../pair_repository.dart';
import 'entity/entities.dart';

final pairsCollection = FirebaseFirestore.instance.collection('pairs');

class FirebasePairRepository implements PairRepository {
  static final FirebasePairRepository _firebasePairRepository =
  FirebasePairRepository._internal();

  FirebasePairRepository._internal();

  factory FirebasePairRepository() {
    return _firebasePairRepository;
  }

  @override
  Future initialize() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  }

  @override
  Stream<List<Pair>> findPairs(int limit,
      [DateTime startAfter, int offset]) {
    var refPairs = pairsCollection.orderBy('date', descending: true).limit(limit);

    if (startAfter != null) {
      refPairs = refPairs.startAfter([startAfter]);
    }

    return refPairs.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Pair.fromEntity(PairEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future insert(Pair pair) {
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
