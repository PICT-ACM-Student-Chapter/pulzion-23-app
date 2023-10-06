import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../constants/urls.dart';

Future<void> remoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig.fetchAndActivate();
  EndPoints.baseUrl = 
  "https://api.pulzion.co.in";
  // remoteConfig.getString('BaseUrl');
  // 'https://ems-test-server.onrender.com';
  EndPoints.sampleToken = remoteConfig.getString('SampleToken');
  EndPoints.appLatestStableVersion =
      remoteConfig.getString('AppLatestStableVersion');
  EndPoints.privacyPolicyURL = remoteConfig.getString('privacyPolicy');
  EndPoints.websiteURL = remoteConfig.getString('websiteUrl');
  EndPoints.playStoreURL = remoteConfig.getString('playstoreUrl');
  EndPoints.sponsorsUrl = remoteConfig.getString('sponsorsUrl');
  EndPoints.acceptingPayment = true;
  // remoteConfig.getBool('AcceptPayment');
  EndPoints.mcqStarted = remoteConfig.getBool('mcqStarted');
  EndPoints.mcqBaseUrl = remoteConfig.getString('mcqBaseUrl');
  EndPoints.referralLink = remoteConfig.getString('ReferalLink');

  return;
}
