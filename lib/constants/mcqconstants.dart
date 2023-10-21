import 'package:flutter/material.dart';
import 'package:pulzion23/constants/urls.dart';

const Color kBackGroundColor = Color(0xFFe0e0e6);
const Color kButtonColor = Color(0xFF1B3357);
const kTextFieldDecoration = InputDecoration(
  hintText: 'Type here',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  // EdgeInsets.all(25),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF73859d), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF73859d), width: 2.5),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
const List<int> division = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

const SizedBox kspaceBetweenTextField = SizedBox(
  height: 20.0,
);

class Constants {
  static String BASE_URL = 'https://api.mcq.pulzion.co.in';
                            //! EndPoints.mcqBaseUrl!;
  static String MCQ_BASE = '$BASE_URL/api';
  static String GET_REGISTERED_EVENTS = '$BASE_URL/user_events';
  static String GET_USER = '$BASE_URL/user/me';
  static String LOGIN_URL = "$BASE_URL/user/signin";
  static String MCQ_LOGIN = "$MCQ_BASE/login";
  static String SIGNUP_URl = "$BASE_URL/user/signup";
  static String EVENT_URL = "$BASE_URL/events";
  static String EVENT_REGISTRATION_URL = "$BASE_URL/user_events";
  static String GET_SLOTS_URL = "$BASE_URL/user_slots?event_id=";
  static String BOOK_SLOT_URL = "$BASE_URL/user_slots";

  static String BASE_MCQ_URL = BASE_URL;
                              // EndPoints.mcqBaseUrl!;
  static String GET_MCQS_URL = '$BASE_MCQ_URL/api/question/list/';
  static String MARK_ANSWER_URL = '$BASE_MCQ_URL/api/question/answer';
  static bool load = false;

  static String GET_MCQ_EVENTS = "$MCQ_BASE/event/list";
  static String GET_MCQ_EVENT_DETAILS = "$MCQ_BASE/event/get/";
  static String SUBMIT_MCQ = "$MCQ_BASE/event/submit/";
}

String? userToken = "";
String? userMCQToken = "";
