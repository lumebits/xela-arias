import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_repository/image_repository.dart';
import 'package:pair_repository/pair_repository.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/models/GenericCard.dart';

part 'detail_event.dart';

class DetailBloc extends Bloc<DetailEvent, String> {
  final ImageRepository imageRepository;
  final PairRepository pairRepository;
  final File imageFile;
  String author;
  GenericCard card;

  DetailBloc(this.imageRepository, this.pairRepository, this.imageFile) : super("");

  @override
  Stream<String> mapEventToState(DetailEvent event) async* {
    if (event is EditAuthorEvent) {
      this.author = event.author;
    } else if (event is InsertEvent) {
      saveImage().then((imageUrl) {
        if (event.card != null) {
          this.card = event.card;
          createPair(imageUrl);
        }
      });
    }
  }

  Future<String> saveImage() async {
    var imageData = new Image(null, null, author, "0", DateTime.now(), false);
    return await imageRepository.insert(imageData, this.imageFile);
  }

  createPair(String imageUrl) async {
    Map<String, dynamic> poemMap = new Map();
    poemMap['id'] = card.id;
    poemMap['author'] = card.textAuthor;
    poemMap['text'] = card.text;

    Map<String, dynamic> imageMap = new Map();
    imageMap['id'] = "";
    imageMap['author'] = author;
    imageMap['url'] = imageUrl;

    var pairData = new Pair(null, "0", DateTime.now(), EntityType.POEM.toString().split('.').last, imageMap, poemMap, false);
    pairRepository.insert(pairData);
  }

}
