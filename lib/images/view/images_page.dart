import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xela_arias/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/pick_image.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/common/widgets/infinite_page.dart';
import 'package:xela_arias/images/bloc/file_card.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';
import 'package:image_repository/image_repository.dart';

class ImagesPage extends BasePage {

  @override
  List<Widget> actions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () =>
            PickImage().pickImage(context, null),
      )
    ];
  }
  
  ImagesPage({Key key, List<Widget> actions}) : super(key, appTab: AppTab.images);

  @override
  Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InfiniteBloc(null, FirebaseImageRepository(), null, EntityType.IMAGE)..add(FetchCards()),
      child: InfinitePage(),
    );
  }

}
