import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/models/GenericCard.dart';
import 'package:xela_arias/images/bloc/file_card.dart';
import 'package:xela_arias/routes.dart';

import 'bottom_loader.dart';

class GenericCardWidget extends StatelessWidget {
  final GenericCard card;

  GenericCardWidget({Key key, @required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        child: Row(
            children: _getOrdered()
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      );
  }

  List<Widget> _getOrdered() {
    if (card.first == EntityType.IMAGE) {
      return [
        ImageItem(card: card),
        PoemItem(card: card)
      ];
    } else {
      return [
        PoemItem(card: card),
        ImageItem(card: card)
      ];
    }
  }
}

class ImageItem extends StatelessWidget {
  final GenericCard card;

  ImageItem({Key key, @required this.card}) : super(key: key);


  Widget _cardImage(BuildContext context) {
    return
      Expanded(
          flex: 5,
          child: Container(
              child: InkWell(
                onTap: () {
                  // TODO: allow only if in poems tab
                  print("Image tapped: " + card.id);
                  _pickImage(context);
                },
                child: Hero(
                  tag: card.id,
                  child: Material(
                    child: CachedNetworkImage(
                      height: (MediaQuery.of(context).size.width / 2 - 20) * (1920 / 1080),
                      imageUrl: card.imageUrl,
                      imageBuilder: (context, imageProvider) => Ink.image(
                        fit: BoxFit.cover,
                        image: imageProvider,
                      ),
                      placeholder: (context, url) => BottomLoader(),
                    ),
                  ),
                ),
              )
          )
      );
  }

  @override
  Widget build(BuildContext context) {
    return _cardImage(context);
  }

  // TODO: refactor, to have this method only in one place
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
        var fileAndCard = FileAndCard(croppedFile, card);
        Navigator.pushNamed(context, XelaAriasRoutes.viewImage, arguments: fileAndCard);
      }
    }
  }
}

class PoemItem extends StatelessWidget {
  final GenericCard card;

  PoemItem({Key key, @required this.card}) : super(key: key);

  Widget _cardText(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        constraints: BoxConstraints(minHeight: 200),
        child:
          InkWell(
            onTap: () {
              // TODO: allow only if in images tab
              print("Poem tapped: " + card.id);
              Navigator.pushNamed(context, XelaAriasRoutes.viewPoem,
                  arguments: card);
            },
            child: Container(
              child:
                Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AutoSizeText(
                        card.text.replaceAll("_b","\n"),
                        maxLines: 30,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    )),
            ),
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _cardText(context);
  }
}
