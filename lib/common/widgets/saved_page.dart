import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'base_page.dart';


class SavedPage extends BasePage {

  SavedPage({Key key, List<Widget> actions}) : super(key, appTab: null);

  @override
  Widget widget(BuildContext context) {
    return
      Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: AutoSizeText(
              "Poema ou imaxe gardado con éxito. Pendente de revisión.",
              maxLines: 30,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontStyle: FontStyle.italic
              ),
            ),
          ));
  }
}
