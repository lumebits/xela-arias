import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xela_arias/common/models/GenericCard.dart';
import 'package:xela_arias/images/bloc/file_card.dart';

import '../routes.dart';

class PickImage {

  final _picker = ImagePicker();

  pickImage(BuildContext context, GenericCard card) async {
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      var fileAndCard = FileAndCard(await image.readAsBytes(), basename(image.path), card);
      Navigator.pushNamed(context, XelaAriasRoutes.cropImage, arguments: fileAndCard);
    }
  }

}
