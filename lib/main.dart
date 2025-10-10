import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/controller/cubit/note_cubit.dart';
import 'package:note_app/views/screens/force_update_view.dart';
import 'package:note_app/views/screens/home_view.dart';

final remoteConfig = FirebaseRemoteConfig.instance;
FirebaseMessaging messaging = FirebaseMessaging.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //! remote config
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ),
  );
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    log("Handling a background message: ${message.messageId}");
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  log('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Got a message whilst in the foreground!');
    log('Message data: ${message.data}');

    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool updatedAppVersion = false;
  String scaffoldColor = "FF020302";
  String appBarColor = "FF35fcdf";
  Future<void> getRemoteConfig() async {
    try {
      await remoteConfig.fetchAndActivate();
      String remoteScaffoldColor = remoteConfig.getString('scaffold_color');
      String remoteAppBarColor = remoteConfig.getString('app_bar_color');
      bool remoteAppVersion = remoteConfig.getBool('update_version');
      // log('Remote update : $remoteAppVersion');
      // log(remoteAppBarColor);
      // log(remoteScaffoldColor);

      setState(() {
        scaffoldColor = remoteScaffoldColor;
        appBarColor = remoteAppBarColor;
        updatedAppVersion = remoteAppVersion;
      });
    } catch (e) {
      log('Error fetching remote config: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await getRemoteConfig();
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

        home: updatedAppVersion ? const ForceUpdateView() : const HomeView(),
      ),
    );
  }
}
  // Future<void> getAppVersion() async {
  //   try {
  //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //     setState(() {
  //       currentAppVersion = packageInfo.version;
  //     });
  //     log('Current app version: $currentAppVersion');
  //   } catch (e) {
  //     log('Error getting package info: $e');
  //   }
  // }