import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xela_arias/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/common/widgets/infinite_page.dart';
import 'package:xela_arias/images/bloc/file_card.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';
import 'package:pair_repository/pair_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:poem_repository/poem_repository.dart';
import 'package:xela_arias/routes.dart';

class ImagesPage extends BasePage {

  @override
  List<Widget> actions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _pickImage(context),
      )
    ];
  }

  _pickImage(BuildContext context) async {
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
        var fileAndCard = FileAndCard(croppedFile, null);
        Navigator.pushNamed(context, XelaAriasRoutes.viewImage, arguments: fileAndCard);
        //Navigator.pushNamed(context, XelaAriasRoutes.viewImage, arguments: croppedFile);
      }
    }
  }

  ImagesPage({Key key, List<Widget> actions}) : super(key, appTab: AppTab.images);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InfiniteBloc(FirebasePairRepository(), FirebaseImageRepository(), FirebasePoemRepository(), EntityType.IMAGE)..add(FetchCards()),
      child: InfinitePage(),
    );
  }

}
