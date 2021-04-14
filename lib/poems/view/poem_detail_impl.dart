import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xela_arias/poems/bloc/detail_bloc.dart';

class PoemDetailImpl extends StatelessWidget {

  PoemDetailImpl();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, String>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) => context.read<DetailBloc>().add(EditAuthorEvent(value)),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black87),
                    focusedBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                    labelText: 'Nome do ou da autor/a do poema',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 10,
                  onChanged: (value) => context.read<DetailBloc>().add(EditPoemEvent(value)),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: Colors.black87),
                    focusedBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                    labelText: 'Escribe aquí o teu poema...',
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
