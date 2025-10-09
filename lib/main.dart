import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/controller/cubit/note_cubit.dart';
import 'package:note_app/views/screens/force_update_view.dart';
import 'package:note_app/views/screens/home_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

final remoteConfig = FirebaseRemoteConfig.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 1),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String updatedAppVersion = "";
  String scaffoldColor = "";
  String appBarColor = "";
  String currentAppVersion = "";
  Future<void> getRemoteConfig() async {
    try {
      await remoteConfig.fetchAndActivate();
      String remoteScaffoldColor = remoteConfig.getString('scaffold_color');
      String remoteAppBarColor = remoteConfig.getString('app_bar_color');
      String remoteAppVersion = remoteConfig.getString('app_version');
      log('Remote app version: $remoteAppVersion');

      setState(() {
        scaffoldColor = remoteScaffoldColor;
        appBarColor = remoteAppBarColor;
        updatedAppVersion = remoteAppVersion;
      });
    } catch (e) {
      log('Error fetching remote config: $e');
    }
  }

  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        currentAppVersion = packageInfo.version;
      });
      log('Current app version: $currentAppVersion');
    } catch (e) {
      log('Error getting package info: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await getRemoteConfig();
    await getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Color(int.tryParse(appBarColor, radix: 16)!),
          ),
          scaffoldBackgroundColor: Color(
            int.tryParse(scaffoldColor, radix: 16)!,
          ),
        ),

        //! currentAppVersion Vs packageInfo
        home: currentAppVersion == updatedAppVersion
            ? const HomeView()
            : const ForceUpdateView(),
      ),
    );
  }
}
