import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_repository/pair_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:poem_repository/poem_repository.dart';
import 'package:xela_arias/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/common/widgets/infinite_page.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';

import '../../routes.dart';

class PoemsPage extends BasePage {

  @override
  List<Widget> actions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, XelaAriasRoutes.viewPoem);
        },
      )
    ];
  }

  PoemsPage({Key key, List<Widget> actions}) : super(key, appTab: AppTab.poems);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InfiniteBloc(FirebasePairRepository(), FirebaseImageRepository(), FirebasePoemRepository(), EntityType.POEM)..add(FetchCards()),
      child: InfinitePage(),
    );
  }
}
