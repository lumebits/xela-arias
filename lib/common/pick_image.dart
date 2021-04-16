
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xela_arias/common/models/GenericCard.dart';
import 'package:xela_arias/images/bloc/file_card.dart';

import '../routes.dart';

class PickImage {

  pickImage(BuildContext context, GenericCard card) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 9, ratioY: 16),
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Nova imaxe',
              toolbarColor: Color(0xFFADD7D6),
              statusBarColor: Colors.white,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
              title: 'Nova imaxe',
              rotateButtonsHidden: true
          ));
      if (croppedFile != null) {
        var fileAndCard = FileAndCard(croppedFile, card);
        Navigator.pushNamed(context, XelaAriasRoutes.viewImage, arguments: fileAndCard);
      }
    }
  }

}
