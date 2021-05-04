import 'package:crop/crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/images/bloc/detail_bloc.dart';
import 'package:xela_arias/images/bloc/file_card.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';

import '../../routes.dart';

class ImageDetailImpl extends BasePage {
  final FileAndCard fileAndCard;

  ImageDetailImpl(this.fileAndCard, {Key key})
      : super(key, appTab: AppTab.images);

  @override
  List<Widget> actions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {
          context.read<DetailBloc>().add(InsertEvent(this.fileAndCard.card));
          Navigator.pushNamed(context, XelaAriasRoutes.saved);
        },
      )
    ];
  }

  @override
  Widget bottomNavigationBar() => null;

  @override
  Widget widget(BuildContext context) {
    final controller = CropController(aspectRatio: 9 / 16);

    return BlocBuilder<DetailBloc, String>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) =>
                      context.read<DetailBloc>().add(EditAuthorEvent(value)),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black87),
                    focusedBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                    labelText: 'Nome do ou da autor/a da imaxe',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.memory(fileAndCard.image, fit: BoxFit.cover),
              )
            ],
          ),
        );
      },
    );
  }
}
