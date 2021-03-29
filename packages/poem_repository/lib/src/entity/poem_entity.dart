import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class PoemEntity extends Equatable {
  final String id;
  final String text;
  final String author;
  final String classroom;
  final DateTime date;

  const PoemEntity(this.id, this.text, this.author, this.classroom,
      this.date);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "text": text,
      "author": author,
      "classroom": classroom,
      "date": date,
    };
  }

  @override
  List<Object> get props => [id, text, author, classroom, date];

  @override
  String toString() {
    return 'PoemEntity { id: $id, text: $text, author: $author, classroom: $classroom, date: $date }';
  }

  static PoemEntity fromJson(Map<String, Object> json) {
    return PoemEntity(
      json.containsKey("id") ? json["id"] as String : null,
      json.containsKey("text") ? json["text"] as String : null,
      json.containsKey("author") ? json["author"] as String : null,
      json.containsKey("classroom") ? json["classroom"] as String : null,
      json.containsKey("date") ? json["date"] as DateTime : null,
    );
  }

  static PoemEntity fromSnapshot(DocumentSnapshot snap) {
    return PoemEntity(
      snap.id,
      snap.get('text'),
      snap.get('author'),
      snap.get('classroom'),
      snap.get('date').toDate(),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "text": text,
      "author": author,
      "classroom": classroom,
      "date": date,
    };
  }
}
