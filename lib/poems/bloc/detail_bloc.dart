import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poem_repository/poem_repository.dart';

part 'detail_event.dart';

class DetailBloc extends Bloc<DetailEvent, String> {
  final PoemRepository poemRepository;
  String author;
  String poem;

  DetailBloc(this.poemRepository) : super("");

  @override
  Stream<String> mapEventToState(DetailEvent event) async* {
    if (event is EditAuthorEvent) {
      this.author = event.author;
    } else if (event is InsertEvent) {
      savePoem();
    }
  }

  savePoem() async {
    var poemData = new Poem(null, poem, author, "0", DateTime.now(), false);
    poemRepository.insert(poemData);
  }

}
