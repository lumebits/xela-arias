import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xela_repository/image_repository.dart';
import 'package:xela_repository/pair_repository.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/models/GenericCard.dart';

part 'detail_event.dart';

class DetailBloc extends Bloc<DetailEvent, String> {
  final ImageRepository imageRepository;
  final PairRepository pairRepository;
  final Uint8List image;
  final String name;
  String author;
  GenericCard card;

  DetailBloc(this.imageRepository, this.pairRepository, this.image, this.name)
      : super("");

  @override
  Stream<String> mapEventToState(DetailEvent event) async* {
    if (event is EditAuthorEvent) {
      this.author = event.author;
    } else if (event is InsertEvent) {
      if (event.card != null) {
        createPair();
      } else {
        saveImage();
      }
    }
  }

  saveImage() async {
    var imageData = new Image(null, null, author, "0", DateTime.now(), false);
    await imageRepository.insert(imageData, this.image, this.name);
  }

  createPair() async {
    Map<String, dynamic> poemMap = new Map();
    poemMap['id'] = card.id;
    poemMap['author'] = card.textAuthor;
    poemMap['text'] = card.text;

    Map<String, dynamic> imageMap = new Map();
    imageMap['id'] = "";
    imageMap['author'] = author;

    var pairData = new Pair(null, "0", DateTime.now(),
        EntityType.POEM.toString().split('.').last, imageMap, poemMap, false);
    pairRepository.insert(pairData, image: this.image, name: this.name);
  }
}
