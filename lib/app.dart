import 'package:flutter/material.dart';
import 'package:xela_arias/home/home.dart';
import 'package:xela_arias/routes.dart';

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
              } else {
                return Center();
              }
            },
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c));
      },
      initialRoute: XelaAriasRoutes.home,
    );
  }
}
