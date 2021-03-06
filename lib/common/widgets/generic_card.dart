import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/models/GenericCard.dart';
import 'package:xela_arias/common/pick_image.dart';
import 'package:xela_arias/routes.dart';

import '../../theme.dart';
import 'bottom_loader.dart';
const double _cardMaxWidth = 1000;

class GenericCardWidget extends StatelessWidget {
  final GenericCard card;

  GenericCardWidget({Key key, @required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Card(
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
          ),
      ),
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

  double _calculateWidth(BuildContext context) {
    return min(MediaQuery.of(context).size.width / 2 - 10, _cardMaxWidth / 2 - 10);
  }

  Widget _cardImage(BuildContext context) {
    var width = _calculateWidth(context);
    return
      Container(
          width: width,
          child: InkWell(
            onTap: () {
              if (card.actualTab == EntityType.POEM) {
                print("Image tapped: " + card.id);
                PickImage().pickImage(context, card);
              }
            },
            child: Hero(
              tag: card.id,
              child: Material(
                child: CachedNetworkImage(
                  height: width * (1920 / 1080),
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
      );
  }

  @override
  Widget build(BuildContext context) {
    return _cardImage(context);
  }
}

class PoemItem extends StatelessWidget {
  final GenericCard card;

  PoemItem({Key key, @required this.card}) : super(key: key);

  double _calculateWidth(BuildContext context) {
    return min(MediaQuery.of(context).size.width / 2 - 10, _cardMaxWidth / 2 - 10);
  }

  Widget _cardText(BuildContext context) {
    var width = _calculateWidth(context);
    String credits = "\n";
    if (card.textAuthor.isNotEmpty) {
      credits += "\nPoema: ${card.textAuthor}";
    }
    if (card.imageAuthor.isNotEmpty) {
      credits += "\nImaxe: ${card.imageAuthor}";
    }
    return Container(
      width: width,
      constraints: BoxConstraints(maxHeight: width * (1920 / 1080)),
      child:
        InkWell(
          onTap: () {
            if (card.actualTab == EntityType.IMAGE) {
              print("Poem tapped: " + card.id);
              Navigator.pushNamed(context, XelaAriasRoutes.viewPoem,
                  arguments: card);
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                child:
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      card.text.replaceAll("_b","\n") + credits,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: kIsWeb ? 18.0 : 14.0
                      ),
                    ),
                  ),
              ),
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
