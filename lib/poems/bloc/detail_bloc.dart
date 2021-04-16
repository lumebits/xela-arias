import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pair_repository/pair_repository.dart';
import 'package:poem_repository/poem_repository.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/models/GenericCard.dart';

part 'detail_event.dart';

class DetailBloc extends Bloc<DetailEvent, String> {
  final PoemRepository poemRepository;
  final PairRepository pairRepository;
  String author;
  String poem;
  GenericCard card;

  DetailBloc(this.poemRepository, this.pairRepository) : super("");

  @override
  Stream<String> mapEventToState(DetailEvent event) async* {
    if (event is EditAuthorEvent) {
      this.author = event.author;
    } if (event is EditPoemEvent) {
      this.poem = event.poem;
    } else if (event is InsertEvent) {
      savePoem();
      if (event.card != null) {
        this.card = event.card;
        createPair();
      }
    }
  }

  savePoem() async {
    var poemData = new Poem(null, poem, author, "0", DateTime.now(), false);
    poemRepository.insert(poemData);
  }

  createPair() async {
    Map<String, dynamic> poemMap = new Map();
    poemMap['id'] = "";
    poemMap['author'] = author;
    poemMap['text'] = poem;

    Map<String, dynamic> imageMap = new Map();
    imageMap['id'] = card.id;
    imageMap['author'] = card.imageAuthor;
    imageMap['url'] = card.imageUrl;

    var pairData = new Pair(null, "0", DateTime.now(), EntityType.IMAGE.toString().split('.').last, imageMap, poemMap, false);
    pairRepository.insert(pairData);
  }

}
