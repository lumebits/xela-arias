import 'package:meta/meta.dart';
import '../entity/entities.dart';

@immutable
class Image {
  final String id;
  final String url;
  final String author;
  final String classroom;
  final DateTime date;

  Image(this.id, this.url, this.author, this.classroom, this.date);

  @override
  int get hashCode =>
      id.hashCode ^
      url.hashCode ^
      author.hashCode ^
      classroom.hashCode ^
      date.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Image &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              url == other.url &&
              author == other.author &&
              classroom == other.classroom &&
              date == other.date;

  @override
  String toString() {
    return 'Image { id: $id, url: $url, author: $author, classroom: $classroom, date: $date }';
  }

  ImageEntity toEntity() {
    return ImageEntity(id, url, author, classroom, date);
  }

  static Image fromEntity(ImageEntity entity) {
    return Image(
      entity.id,
      entity.url,
      entity.author,
      entity.classroom,
      entity.date,
    );
  }
}
