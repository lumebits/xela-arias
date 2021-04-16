import 'package:flutter/material.dart';
import 'package:xela_arias/common/widgets/saved_page.dart';
import 'package:xela_arias/home/home.dart';
import 'package:xela_arias/images/view/image_detail.dart';
import 'package:xela_arias/poems/view/poem_detail.dart';
import 'package:xela_arias/poems/view/poems_page.dart';
import 'package:xela_arias/routes.dart';

import 'images/view/images_page.dart';
import 'routes.dart';

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proxecto Xela Arias',
        onGenerateRoute: (settings) {
          return PageRouteBuilder(
              pageBuilder: (_, __, ___) {
                if (settings.name == XelaAriasRoutes.home) {
                  return HomePage();
                } else if (settings.name == XelaAriasRoutes.images) {
                  return ImagesPage();
                }  else if (settings.name == XelaAriasRoutes.poems) {
                  return PoemsPage();
                } else if (settings.name == XelaAriasRoutes.viewImage) {
                  return ImageDetail(settings.arguments);
                } else if (settings.name == XelaAriasRoutes.viewPoem) {
                  return PoemDetail(settings.arguments);
                } else if (settings.name == XelaAriasRoutes.saved) {
                  return SavedPage();
                } else {
                    return HomePage();
                }
              },
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c));
        },
        initialRoute: XelaAriasRoutes.home,
      );
  }
}
