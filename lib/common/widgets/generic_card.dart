import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xela_arias/common/models/GenericCard.dart';
import 'package:xela_arias/routes.dart';

import 'bottom_loader.dart';

// TODO:
//  - highlight "first"

class GenericCardWidget extends StatelessWidget {
  final GenericCard card;

  GenericCardWidget({Key key, @required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        child: Row(
            children: <Widget>[
                Expanded(
                  flex: 5,
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          print("Image tapped: " + card.id);
                          Navigator.pushNamed(context, XelaAriasRoutes.addImage,
                              arguments: card);
                        },
                        onLongPress: () async {
                          print("Long pressed card: " + card.id);
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
                      )
                    )
                ),
                PoemItem(card: card),
            ]
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      );
  }
}


class PoemItem extends StatelessWidget {
  final GenericCard card;

  PoemItem({Key key, @required this.card}) : super(key: key);

  Widget _cardText(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.star_border),
                onPressed: () {
                  /* ... */
                },
              ),
            ],
          ),
          InkWell(
            onTap: () {
              print("Poem tapped: " + card.id);
              Navigator.pushNamed(context, XelaAriasRoutes.addPoem,
                  arguments: card);
            },
            onLongPress: () async {
              print("Long pressed card: " + card.id);
            },
            child: Column(
              children: [
                Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AutoSizeText(
                        card.text.replaceAll("_b","\n"),
                        maxLines: 18,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _cardText(context);
  }
}
