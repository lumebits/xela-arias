import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../image_repository.dart';
import 'entity/entities.dart';

final imagesCollection = FirebaseFirestore.instance.collection('images');

class FirebaseImageRepository implements ImageRepository {
  static final FirebaseImageRepository _firebaseImageRepository =
      FirebaseImageRepository._internal();

  FirebaseImageRepository._internal();

  factory FirebaseImageRepository() {
    return _firebaseImageRepository;
  }

  @override
  Future initialize() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  }

  @override
  Stream<List<Image>> findImages(int limit, [DateTime startAfter, int offset]) {
    var refImages = imagesCollection
        .where('validated', isEqualTo: true)
        .orderBy('date', descending: true)
        .limit(limit);

    if (startAfter != null) {
      refImages = refImages.startAfter([startAfter]);
    }

    return refImages.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Image.fromEntity(ImageEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future insert(Image image, Uint8List uint8list, String name) async {
    String fileName = getRandomString(15) + name;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('/$fileName');

    await firebaseStorageRef.putData(uint8list).then(
        (taskSnapshot) => taskSnapshot.ref.getDownloadURL().then((value) => {
              print("Done: $value"),
              imagesCollection.add({
                'author': image.author,
                'classroom': image.classroom,
                'date': image.date,
                'url': value,
                'validated': image.validated,
              })
            }));
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
