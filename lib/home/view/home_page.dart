import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xela_arias/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/common/widgets/infinite_page.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';
import 'package:xela_repository/pair_repository.dart';
import 'package:xela_repository/image_repository.dart';
import 'package:xela_repository/poem_repository.dart';

class HomePage extends BasePage {
  HomePage({Key key}) : super(key, appTab: AppTab.home);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InfiniteBloc(FirebasePairRepository(), FirebaseImageRepository(), FirebasePoemRepository(), EntityType.PAIR)..add(FetchCards()),
      child: InfinitePage(),
    );
  }
}
