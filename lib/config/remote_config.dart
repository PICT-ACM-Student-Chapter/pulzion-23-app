import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../constants/urls.dart';

Future<void> remoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig.fetchAndActivate();
  EndPoints.baseUrl = remoteConfig.getString('BaseUrl');
  EndPoints.sampleToken = remoteConfig.getString('SampleToken');
  log(EndPoints.baseUrl as String);
  log(EndPoints.sampleToken as String);
  return;
}
