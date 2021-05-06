import 'package:flutter/material.dart';
import '../../routes.dart';
import '../../theme.dart';
import 'base_page.dart';


class ProjectPage extends BasePage {

  ProjectPage({Key key, List<Widget> actions}) : super(key, appTab: null);

  @override
  Widget bottomNavigationBar() => null;

  @override
  Widget widget(BuildContext context) {
    return
      SingleChildScrollView(
        child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "O 2021 homenaxea polas Letras Galegas a Xela Arias e, navegando pola súa bibliografía, "
                      "topamos con ''Tigres coma cabalos'', unha obra na cal ela e o fotógrafo Xulio Gil intercambian "
                      "as súas obras para completalas. Xulio aportou 24 imaxes ás que Xela engadiu versos e Xela 24 "
                      "poemas aos que Xulio uniu fotografías para completar o álbum.\n\n''Tigres coma cabalos'' serve como "
                      "alicerce para o proxecto escolar Xela Arias no cal facemos un exercicio semellante para crear "
                      "a nosa galería particular do proxecto Xela. Practicaremos escrita creativa e fotografía/ilustración "
                      "aportando letras a imaxes de compañeiros/as ou imaxes a versos alleos así como engadindo tamén "
                      "fotos e textos para que outros poidan completar coas súas obras. Aceptas o reto? Achégate ao "
                      "museo do Proxecto Xela Arias, inspírate, partilla e desfruta. Un mundo de imaxe, un mundo de palabras. ",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    Image.asset("assets/xela-init.png"),
                    SizedBox(height: 20),
                    Material(
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0)),
                      color: Color(0xFFADD7D6),
                      elevation: 18.0,
                      clipBehavior: Clip.antiAlias,
                      child: MaterialButton(
                        height: 48,
                        onPressed: () => Navigator.pushNamed(context, XelaAriasRoutes.home),
                        textColor: Colors.white,
                        color: Color(0xFFADD7D6),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Acepto o reto!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      );
  }
}
