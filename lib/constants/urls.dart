class EndPoints {
  static String? sampleToken;
  static String? baseUrl;
  static String? appLatestStableVersion;
  static String? privacyPolicyURL;
  static String? websiteURL;
  static String? playStoreURL;
  static String? sponsorsUrl;
  static bool? acceptingPayment;
  static bool? mcqStarted;
  static String? referralLink;
  static String? mcqBaseUrl;

  static String events = '${baseUrl!}/events';
  static String user = '${baseUrl!}/user/me';
  static String login = '${baseUrl!}/user/signin';
  static String signup = '${baseUrl!}/user/signup';
  static String addFCMToken = '${baseUrl!}/fcm_token/';
  static String cart = '${baseUrl!}/cart/';
  static String transaction = '${baseUrl!}/transaction';
  static String otp = '${baseUrl!}/user/otp';
  static String forget = '${baseUrl!}/user/forget';
  static String userEvents = '${baseUrl!}/user_events';
  static String getSlots = '${baseUrl!}/user_slots?event_id=';
  static String bookSlots = '${baseUrl!}/user_slots';
}
