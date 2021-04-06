import 'package:xela_arias/common/models/EntityType.dart';

class GenericCard {
  final String id;
  final String text;
  final String textAuthor;
  final String imageUrl;
  final String imageAuthor;
  final EntityType first;
  final DateTime date;

  GenericCard(this.id, this.text, this.textAuthor, this.imageUrl, this.imageAuthor, this.first, this.date);
}
