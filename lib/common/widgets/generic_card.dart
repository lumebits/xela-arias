import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xela_arias/common/models/GenericCard.dart';
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
      child: InkWell(
        onTap: () {
          print("GenericCard tapped: " + card.id);
          Navigator.pushNamed(context, XelaAriasRoutes.images,
              arguments: card);
        },
        onLongPress: () async {
          print("Long pressed card");
        },
        child: Hero(
          tag: card.id,
          child: Material(
            child: CachedNetworkImage(
              height: (MediaQuery.of(context).size.width / 2 - 20) * (1920 / 1080),
              imageUrl: card.imageUrl,
              imageBuilder: (context, imageProvider) => Ink.image(
                fit: BoxFit.fill,
                image: imageProvider,
              ),
              placeholder: (context, url) => BottomLoader(),
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
