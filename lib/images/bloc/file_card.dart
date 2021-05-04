import 'dart:typed_data';

import 'package:xela_arias/common/models/GenericCard.dart';

class FileAndCard {
  final Uint8List image;
  final String fileName;
  final GenericCard card;

  FileAndCard(this.image, this.fileName, this.card);

}
