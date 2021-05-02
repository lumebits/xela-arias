import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xela_arias/app.dart';
import 'package:xela_repository/pair_repository.dart';
import 'package:xela_repository/image_repository.dart';
import 'package:xela_repository/poem_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  await FirebasePairRepository().initialize();
  await FirebaseImageRepository().initialize();
  await FirebasePoemRepository().initialize();
  await FirebaseAuth.instance.signInAnonymously();
  runApp(App());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(cubit, error, stackTrace);
  }
}
