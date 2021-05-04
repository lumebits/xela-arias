import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xela_repository/image_repository.dart';
import 'package:xela_repository/pair_repository.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/models/GenericCard.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ImageRepository imageRepository;
  final PairRepository pairRepository;
  final Uint8List image;
  final String name;
  String author;
  GenericCard card;

  DetailBloc(this.imageRepository, this.pairRepository, this.image, this.name)
      : super(DetailInitial());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is EditAuthorEvent) {
      this.author = event.author;
    } else if (event is InsertEvent) {
      yield Uploading();
      if (event.card != null) {
        await createPair();
      } else {
        await saveImage();
      }
      yield UploadSuccess();
    }
  }

  Future saveImage() async {
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
    await pairRepository.insert(pairData, image: this.image, name: this.name);
  }
}
