import 'package:crop/crop.dart';
import 'package:flutter/material.dart';
import 'package:xela_arias/images/bloc/file_card.dart';

import 'dart:ui' as ui;

import '../../routes.dart';

class ImageCropPage extends StatefulWidget {
  final FileAndCard fileAndCard;

  ImageCropPage(this.fileAndCard);

  @override
  _ImageCropPageState createState() => _ImageCropPageState(this.fileAndCard);
}

class _ImageCropPageState extends State<ImageCropPage> {
  final controller = CropController(aspectRatio: 9 / 16);
  final FileAndCard fileAndCard;

  _ImageCropPageState(this.fileAndCard);

  void _cropImage() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cropped = await controller.crop(pixelRatio: pixelRatio);
    final byteData = await cropped.toByteData(format: ui.ImageByteFormat.png);
    var fileAndCardCropped = FileAndCard(
        byteData.buffer.asUint8List(), fileAndCard.fileName, fileAndCard.card);

    Navigator.pushNamed(context, XelaAriasRoutes.viewImage,
        arguments: fileAndCardCropped);


    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => Scaffold(
    //       appBar: AppBar(
    //         title: Text('Crop Result'),
    //         centerTitle: true,
    //       ),
    //       body: Center(
    //         child: Image.memory(fileAndCardCropped.image),
    //       ),
    //     ),
    //     fullscreenDialog: true,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Demo'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: _cropImage,
            tooltip: 'Crop',
            icon: Icon(Icons.crop),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(8),
              child: Crop(
                onChanged: (decomposition) {
                  print(
                      "Scale : ${decomposition.scale}, Rotation: ${decomposition.rotation}, translation: ${decomposition.translation}");
                },
                controller: controller,
                shape: BoxShape.rectangle,
                child: Image.memory(
                  fileAndCard.image,
                  fit: BoxFit.cover,
                ),
                /* It's very important to set `fit: BoxFit.cover`.
                   Do NOT remove this line.
                   There are a lot of issues on github repo by people who remove this line and their image is not shown correctly.
                */
                helper: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.undo),
                tooltip: 'Undo',
                onPressed: () {
                  controller.rotation = 0;
                  controller.scale = 1;
                  controller.offset = Offset.zero;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
