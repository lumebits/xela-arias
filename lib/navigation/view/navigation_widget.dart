import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xela_arias/xela_arias_keys.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';
import 'package:xela_arias/routes.dart';

class NavigationWidget extends StatelessWidget {
  final AppTab activeTab;

  NavigationWidget({Key key, this.activeTab = AppTab.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      key: XelaAriasKeys.navigation,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) {
        var appTab = AppTab.values[index];
        Navigator.pushNamed(
            context,
            appTab == AppTab.home ? XelaAriasRoutes.home
                : (appTab == AppTab.poems ? XelaAriasRoutes.poems
                : XelaAriasRoutes.images));
      },
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      borderRadius: 36,
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
      fontSize: kIsWeb ? 14.0 : 11.0,
      items: [
        FloatingNavbarItem(icon: Icons.image, title: "Imaxes"),
        FloatingNavbarItem(icon: Icons.home, title: "Galería"),
        FloatingNavbarItem(icon: Icons.text_snippet, title: "Poemas"),
      ],
    );
  }
}
