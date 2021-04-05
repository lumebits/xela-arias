import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xela_arias/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/common/widgets/infinite_page.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';
import 'package:pair_repository/pair_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:poem_repository/poem_repository.dart';

class ImagesPage extends BasePage {
  final actions = <Widget>[
    IconButton(
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        print("Add image.");
      },
    )
  ];
  ImagesPage({Key key, List<Widget> actions}) : super(key, appTab: AppTab.images, actions: actions);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InfiniteBloc(FirebasePairRepository(), FirebaseImageRepository(), FirebasePoemRepository())..add(FetchCards()),
      child: InfinitePage(),
    );
  }
}
