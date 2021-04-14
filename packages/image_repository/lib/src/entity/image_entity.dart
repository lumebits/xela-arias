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
  final bool validated;

  const ImageEntity(this.id, this.url, this.author, this.classroom, this.date, this.validated);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "url": url,
      "author": author,
      "classroom": classroom,
      "date": date,
      "validated": validated,
    };
  }

  @override
  List<Object> get props => [id, url, author, classroom, date, validated];

  @override
  String toString() {
    return 'ImageEntity { id: $id, url: $url, author: $author, classroom: $classroom, date: $date, validated: $validated }';
  }

  static ImageEntity fromJson(Map<String, Object> json) {
    return ImageEntity(
      json.containsKey("id") ? json["id"] as String : null,
      json.containsKey("url") ? json["url"] as String : null,
      json.containsKey("author") ? json["author"] as String : null,
      json.containsKey("classroom") ? json["classroom"] as String : null,
      json.containsKey("date") ? json["date"] as DateTime : null,
      json.containsKey("validated") ? json["validated"] as bool : null,
    );
  }

  static ImageEntity fromSnapshot(DocumentSnapshot snap) {
    return ImageEntity(
      snap.id,
      snap.get('url'),
      snap.get('author'),
      snap.get('classroom'),
      snap.get('date').toDate(),
      snap.get('validated'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "url": url,
      "author": author,
      "classroom": classroom,
      "date": date,
      "validated": validated,
    };
  }
}
