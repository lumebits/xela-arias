import 'package:flutter/material.dart';
import 'package:xela_arias/theme.dart';
import 'base_page.dart';


class SavedPage extends BasePage {

  SavedPage({Key key, List<Widget> actions}) : super(key, appTab: null);

  @override
  Widget widget(BuildContext context) {
    return
      SingleChildScrollView(
        child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Imaxe ou poema gardado con éxito!\n(Aínda non está visible xa que está pendente de revisión)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 17,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    SizedBox(height: 30),
                    Image.asset("assets/xela-saved.png")
                  ],
                ),
              ),
            )),
      );
  }
}
