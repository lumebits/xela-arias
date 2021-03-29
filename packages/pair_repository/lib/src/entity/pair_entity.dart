import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poem_repository/poem_repository.dart';
import 'package:image_repository/image_repository.dart';

@immutable
class PairEntity extends Equatable {
  final String id;
  final String classroom;
  final DateTime date;
  final String first;
  final Image image;
  final Poem poem;

  const PairEntity(this.id, this.classroom, this.date, this.first, this.image, this.poem);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "classroom": classroom,
      "date": date,
      "first": first,
      "image": image,
      "poem": poem,
    };
  }

  @override
  List<Object> get props => [id, classroom, date, first, image, poem];

  @override
  String toString() {
    return 'PairEntity { id: $id, classroom: $classroom, date: $date, first: $first, image: $image, poem: $poem }';
  }

  static PairEntity fromJson(Map<String, Object> json) {
    return PairEntity(
      json.containsKey("id") ? json["id"] as String : null,
      json.containsKey("classroom") ? json["classroom"] as String : null,
      json.containsKey("date") ? json["date"] as DateTime : null,
      json.containsKey("first") ? json["first"] as String : null,
      json.containsKey("image") ? json["image"] as Image : null,
      json.containsKey("poem") ? json["poem"] as Poem : null,
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
    );
  }

  Map<String, Object> toDocument() {
    return {
      "classroom": classroom,
      "date": date,
      "first": first,
      "image": image,
      "poem": poem
    };
  }
}
