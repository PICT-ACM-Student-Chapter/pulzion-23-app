class EndPoints {
  static String? sampleToken;
  static String? baseUrl;
  static String events = '${baseUrl!}/events';
  static String user = '${baseUrl!}/user/me';
  static String login = '${baseUrl!}/user/signin';
  static String signup = '${baseUrl!}/user/signup';
  static String addFCMToken = '${baseUrl!}/fcm_token/';
}
