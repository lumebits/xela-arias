import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_repository/image_repository.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/images/bloc/detail_bloc.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';

import 'image_detail_impl.dart';

class ImageDetail extends BasePage {
  final File image;

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

  ImageDetail(File this.image, {Key key, List<Widget> actions})
      : super(key, appTab: AppTab.images);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DetailBloc(FirebaseImageRepository(), this.image),
      child: ImageDetailImpl(this.image),
    );
  }

  @override
  Widget bottomNavigationBar() => null;
}
