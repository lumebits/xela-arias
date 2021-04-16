import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_repository/pair_repository.dart';
import 'package:poem_repository/poem_repository.dart';
import 'package:xela_arias/common/models/GenericCard.dart';
import 'package:xela_arias/poems/bloc/detail_bloc.dart';

import 'poem_detail_impl.dart';

class PoemDetail extends StatelessWidget {
  final GenericCard card;

  PoemDetail(this.card);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailBloc(FirebasePoemRepository(), FirebasePairRepository()),
      child: PoemDetailImpl(this.card),
    );
  }

}
