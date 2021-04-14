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
  final bool validated;

  const PoemEntity(this.id, this.text, this.author, this.classroom, this.date, this.validated);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "text": text,
      "author": author,
      "classroom": classroom,
      "date": date,
      "validated": validated,
    };
  }

  @override
  List<Object> get props => [id, text, author, classroom, date, validated];

  @override
  String toString() {
    return 'PoemEntity { id: $id, text: $text, author: $author, classroom: $classroom, date: $date, validated: $validated }';
  }

  static PoemEntity fromJson(Map<String, Object> json) {
    return PoemEntity(
      json.containsKey("id") ? json["id"] as String : null,
      json.containsKey("text") ? json["text"] as String : null,
      json.containsKey("author") ? json["author"] as String : null,
      json.containsKey("classroom") ? json["classroom"] as String : null,
      json.containsKey("date") ? json["date"] as DateTime : null,
      json.containsKey("validated") ? json["validated"] as bool : null,
    );
  }

  static PoemEntity fromSnapshot(DocumentSnapshot snap) {
    return PoemEntity(
      snap.id,
      snap.get('text'),
      snap.get('author'),
      snap.get('classroom'),
      snap.get('date').toDate(),
      snap.get('validated'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "text": text,
      "author": author,
      "classroom": classroom,
      "date": date,
      "validated": validated,
    };
  }
}
