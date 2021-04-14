import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_repository/image_repository.dart';
import 'package:xela_arias/images/bloc/detail_bloc.dart';

import 'image_detail_impl.dart';

class ImageDetail extends StatelessWidget {
  final File image;

  ImageDetail(this.image);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailBloc(FirebaseImageRepository(), this.image),
      child: ImageDetailImpl(this.image),
    );
  }
}
