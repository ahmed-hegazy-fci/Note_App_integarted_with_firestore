import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppProvider extends ChangeNotifier {
  //! RemotConfigFireBase
  final remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> getRemoteConfig() async {
    remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );
    notifyListeners();
  }

  //! getAppVersion
  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageInfo.version;
    notifyListeners();
  }

  //!FireBase Analytics Event Loger
  Future<void> addTaskEvent(String title, DateTime time) async {
    await FirebaseAnalytics.instance.logEvent(
      name: "User Add Task",
      parameters: {"item_title": title, "item_date": time},
    );
    notifyListeners();
  }
}
