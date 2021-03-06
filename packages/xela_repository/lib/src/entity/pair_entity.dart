import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class PairEntity extends Equatable {
  final String id;
  final String classroom;
  final DateTime date;
  final String first;
  final Map<String, dynamic> image;
  final Map<String, dynamic> poem;
  final bool validated;

  const PairEntity(this.id, this.classroom, this.date, this.first, this.image, this.poem, this.validated);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "classroom": classroom,
      "date": date,
      "first": first,
      "image": image,
      "poem": poem,
      "validated": validated,
    };
  }

  @override
  List<Object> get props => [id, classroom, date, first, image, poem, validated];

  @override
  String toString() {
    return 'PairEntity { id: $id, classroom: $classroom, date: $date, first: $first, image: $image, poem: $poem, validated: $validated }';
  }

  static PairEntity fromJson(Map<String, Object> json) {
    return PairEntity(
      json.containsKey("id") ? json["id"] as String : null,
      json.containsKey("classroom") ? json["classroom"] as String : null,
      json.containsKey("date") ? json["date"] as DateTime : null,
      json.containsKey("first") ? json["first"] as String : null,
      json.containsKey("image") ? json["image"] as Map<String, dynamic> : null,
      json.containsKey("poem") ? json["poem"] as Map<String, dynamic> : null,
      json.containsKey("validated") ? json["validated"] as bool : null,
    );
  }

  static PairEntity fromSnapshot(DocumentSnapshot snap) {
    return PairEntity(
      snap.id,
      snap.get('classroom'),
      snap.get('date').toDate(),
      snap.get('first'),
      snap.get('image'),
      snap.get('poem'),
      snap.get('validated'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "classroom": classroom,
      "date": date,
      "first": first,
      "image": image,
      "poem": poem,
      "validated": validated,
    };
  }
}
