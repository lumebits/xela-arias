import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';

class ImagesPage extends BasePage {
  ImagesPage({Key key}) : super(key, appTab: AppTab.images);

  @override
  Widget widget(BuildContext context) {
    return Center();
  }
}
