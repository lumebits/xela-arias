import 'package:flutter/material.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';
import 'package:xela_arias/navigation/view/navigation_widget.dart';
import 'package:xela_arias/theme.dart';

abstract class BasePage extends StatelessWidget {
  final AppTab appTab;
  final String title;

  const BasePage(Key key, {this.appTab, this.title})
      : super(key: key);

  Widget bottomNavigationBar() => NavigationWidget(activeTab: appTab);

  List<Widget> actions(BuildContext context) => null;

  Widget floatingActionButton(BuildContext context) => null;

  Widget widget(BuildContext context);

  Widget appBar(context) {
    return AppBar(
      leading: null,
      title: title != null
          ? Text(title, style: TextStyle(color: Colors.white))
          : Container(
              child: Hero(tag: "logo", child: appLogo),
              height: 45,
            ),
      centerTitle: true,
      backgroundColor: Color(0xFFADD7D6),
      actions: actions(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xEFFFFFFF),
      appBar: appBar(context),
      extendBody: true,
      body: Column(
        children: [
          //AdmobHelper().nativeAd(),
          Expanded(
            child: Stack(
              children: [
                widget(context),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton(context),
        bottomNavigationBar: bottomNavigationBar()
    );
  }
}
