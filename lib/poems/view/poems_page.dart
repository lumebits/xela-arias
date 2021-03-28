import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';

class PoemsPage extends BasePage {
  final actions = <Widget>[
    IconButton(
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        print("Add poem.");
      },
    )
  ];
  PoemsPage({Key key, List<Widget> actions}) : super(key, appTab: AppTab.poems, actions: actions);

  @override
  Widget widget(BuildContext context) {
    return Center();
  }
}
