import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xela_arias/common/widgets/base_page.dart';
import 'package:xela_arias/images/bloc/detail_bloc.dart';
import 'package:xela_arias/images/bloc/file_card.dart';
import 'package:xela_arias/navigation/model/app_tab.dart';

import '../../routes.dart';
import '../../theme.dart';

class ImageDetailImpl extends BasePage {
  final FileAndCard fileAndCard;

  ImageDetailImpl(this.fileAndCard, {Key key})
      : super(key, appTab: AppTab.images);

  @override
  List<Widget> actions(BuildContext context) {
    return [
      BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
        if (state is DetailInitial || state is UploadFailure) {
          return IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              context
                  .read<DetailBloc>()
                  .add(InsertEvent(this.fileAndCard.card));
            },
          );
        } else {
          return Container(
              padding: EdgeInsets.all(10), child: CircularProgressIndicator());
        }
      })
    ];
  }

  @override
  Widget bottomNavigationBar() => null;

  @override
  Widget widget(BuildContext context) {
    return BlocListener<DetailBloc, DetailState>(
      listener: (context, state) {
        if (state is UploadSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, XelaAriasRoutes.saved,
              ModalRoute.withName(XelaAriasRoutes.home));
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 15, right: 15, bottom: 10),
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
                  padding: const EdgeInsets.only(
                      left: 15, top: 5, right: 15, bottom: 15),
                  child: Image.memory(fileAndCard.image, fit: BoxFit.cover),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
