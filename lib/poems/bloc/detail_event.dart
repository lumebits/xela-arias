part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class InsertEvent extends DetailEvent {
  final GenericCard card;

  const InsertEvent(this.card);
}

class EditAuthorEvent extends DetailEvent {
  final String author;

  const EditAuthorEvent(this.author);
}

class EditPoemEvent extends DetailEvent {
  final String poem;

  const EditPoemEvent(this.poem);
}
