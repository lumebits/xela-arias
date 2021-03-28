import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';

class PoemsPage extends BasePage {
  PoemsPage({Key key}) : super(key, appTab: AppTab.poems);

  @override
  Widget widget(BuildContext context) {
    return Center();
  }
}
