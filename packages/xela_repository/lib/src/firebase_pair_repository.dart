import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Stream<List<Pair>> findPairs(int limit, [DateTime startAfter, int offset]) {
    var refPairs = pairsCollection
        .where('validated', isEqualTo: true)
        .orderBy('date', descending: true)
        .limit(limit);

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
  Future insert(Pair pair, {Uint8List image, String name}) async {
    if (image == null || name == null) {
      _insert(pair);
    } else {
      String fileName = getRandomString(15) + name;
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putData(image);
      TaskSnapshot taskSnapshot = uploadTask.snapshot;
      taskSnapshot.ref.getDownloadURL().then((value) => {
            print("Done: $value"),
            pairsCollection.add({
              'classroom': pair.classroom,
              'date': pair.date,
              'first': pair.first,
              'validated': pair.validated,
              'image': pair.image,
              'poem': pair.poem
            })
          });
    }
  }

  Future _insert(Pair pair) async {
    await pairsCollection.add({
      'classroom': pair.classroom,
      'date': pair.date,
      'first': pair.first,
      'validated': pair.validated,
      'image': pair.image,
      'poem': pair.poem
    });
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

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
