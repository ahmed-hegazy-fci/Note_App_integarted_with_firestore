import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/controller/cubit/note_cubit.dart';
import 'package:note_app/controller/provider/provider.dart';
import 'package:note_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/views/screens/error_view.dart';
import 'package:note_app/views/screens/home_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  //! Error Widget
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorView(message: details.toString());
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => NoteCubit()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
      ],
      child: const MaterialApp(home: HomeView()),
    );
  }
}
