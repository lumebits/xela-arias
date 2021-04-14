import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poem_repository/poem_repository.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/poems/bloc/detail_bloc.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';

import 'poem_detail_impl.dart';

class PoemDetail extends BasePage {

  @override
  List<Widget> actions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () => context.read<DetailBloc>().add(InsertEvent()),
      )
    ];
  }

  PoemDetail({Key key, List<Widget> actions})
      : super(key, appTab: AppTab.poems);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailBloc(FirebasePoemRepository()),
      child: PoemDetailImpl(),
    );
  }

  @override
  Widget bottomNavigationBar() => null;
}
