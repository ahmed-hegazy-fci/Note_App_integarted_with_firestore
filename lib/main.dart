import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/views/screens/home_view.dart';
import 'package:note_app/controller/cubit/note_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xffF7FCFC)),
          scaffoldBackgroundColor: const Color(0xffF7FCFC),
        ),
        home: const HomeView(),
      ),
    );
  }
}
