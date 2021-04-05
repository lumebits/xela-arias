import 'package:meta/meta.dart';
import '../entity/entities.dart';

@immutable
class Pair {
  final String id;
  final String classroom;
  final DateTime date;
  final String first;
  final Map<String, dynamic> image;
  final Map<String, dynamic> poem;

  Pair(this.id, this.classroom, this.date, this.first, this.image, this.poem);

  @override
  int get hashCode =>
      id.hashCode ^
      classroom.hashCode ^
      date.hashCode ^
      first.hashCode ^
      image.hashCode ^
      poem.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pair &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              classroom == other.classroom &&
              date == other.date &&
              first == other.first &&
              image == other.image &&
              poem == other.poem;

  @override
  String toString() {
    return 'Pair { id: $id, classroom: $classroom, date: $date, first: $first, image: $image, poem: $poem }';
  }

  PairEntity toEntity() {
    return PairEntity(id, classroom, date, first, image, poem);
  }

  static Pair fromEntity(PairEntity entity) {
    return Pair(
      entity.id,
      entity.classroom,
      entity.date,
      entity.first,
      entity.image,
      entity.poem,
    );
  }
}
