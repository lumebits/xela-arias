part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class InsertEvent extends DetailEvent {}

class EditAuthorEvent extends DetailEvent {
  final String author;

  const EditAuthorEvent(this.author);
}