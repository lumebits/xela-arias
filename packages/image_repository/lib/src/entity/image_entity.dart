import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ImageEntity extends Equatable {
  final String id;
  final String url;
  final String author;
  final String classroom;
  final DateTime date;

  const ImageEntity(this.id, this.url, this.author, this.classroom, this.date);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "url": url,
      "author": author,
      "classroom": classroom,
      "date": date,
    };
  }

  @override
  List<Object> get props => [id, url, author, classroom, date];

  @override
  String toString() {
    return 'ImageEntity { id: $id, url: $url, author: $author, classroom: $classroom, date: $date }';
  }

  static ImageEntity fromJson(Map<String, Object> json) {
    return ImageEntity(
      json.containsKey("id") ? json["id"] as String : null,
      json.containsKey("url") ? json["url"] as String : null,
      json.containsKey("author") ? json["author"] as String : null,
      json.containsKey("classroom") ? json["classroom"] as String : null,
      json.containsKey("date") ? json["date"] as DateTime : null,
    );
  }

  static ImageEntity fromSnapshot(DocumentSnapshot snap) {
    return ImageEntity(
      snap.id,
      snap.get('url'),
      snap.get('author'),
      snap.get('classroom'),
      snap.get('date').toDate(),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "url": url,
      "author": author,
      "classroom": classroom,
      "date": date,
    };
  }
}
