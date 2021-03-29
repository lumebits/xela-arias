import 'package:meta/meta.dart';
import '../entity/entities.dart';

@immutable
class Poem {
  final String id;
  final String text;
  final String author;
  final String classroom;
  final DateTime date;

  Poem(this.id, this.text, this.author, this.classroom, this.date);

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      author.hashCode ^
      classroom.hashCode ^
      date.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Poem &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              text == other.text &&
              author == other.author &&
              classroom == other.classroom &&
              date == other.date;

  @override
  String toString() {
    return 'Poem { id: $id, text: $text, author: $author, classroom: $classroom, date: $date }';
  }

  PoemEntity toEntity() {
    return PoemEntity(id, text, author, classroom, date);
  }

  static Poem fromEntity(PoemEntity entity) {
    return Poem(
      entity.id,
      entity.text,
      entity.author,
      entity.classroom,
      entity.date,
    );
  }
}
