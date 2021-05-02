import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../entity/entities.dart';

@immutable
class Poem {
  final String id;
  final String text;
  final String author;
  final String classroom;
  final DateTime date;
  final bool validated;

  Poem(this.id, this.text, this.author, this.classroom, this.date, this.validated);

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      author.hashCode ^
      classroom.hashCode ^
      date.hashCode ^
      validated.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Poem &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              text == other.text &&
              author == other.author &&
              classroom == other.classroom &&
              date == other.date &&
              validated == other.validated;

  @override
  String toString() {
    return 'Poem { id: $id, text: $text, author: $author, classroom: $classroom, date: $date, validated: $validated }';
  }

  PoemEntity toEntity() {
    return PoemEntity(id, text, author, classroom, date, validated);
  }

  static Poem fromEntity(PoemEntity entity) {
    return Poem(
      entity.id,
      entity.text,
      entity.author,
      entity.classroom,
      entity.date,
      entity.validated,
    );
  }
}
