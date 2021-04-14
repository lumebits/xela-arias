import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_repository/image_repository.dart';

part 'detail_event.dart';

class DetailBloc extends Bloc<DetailEvent, String> {
  final ImageRepository imageRepository;
  final File imageFile;
  String author;

  DetailBloc(this.imageRepository, this.imageFile) : super("");

  @override
  Stream<String> mapEventToState(DetailEvent event) async* {
    if (event is EditAuthorEvent) {
      this.author = event.author;
    } else if (event is InsertEvent) {
      saveImage();
    }
  }

  saveImage() async {
    var imageData = new Image(null, null, author, "0", DateTime.now(), false);
    imageRepository.insert(imageData, this.imageFile);
  }

}
