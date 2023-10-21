// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:pulzion22_app/models/question_overview.dart';

import '../../../../constants/mcqconstants.dart';
// import '../../constants/constants.dart';
import '../../data/models/question_overview.dart';
// import '../../services/mcq_user_provider.dart';

class QuestionGrid extends StatefulWidget {
  List<CustomQuestionOverview> question_overview;
  final storage = FlutterSecureStorage();

  QuestionGrid({required this.question_overview, Key? key}) : super(key: key);

  @override
  _QuestionGridState createState() => _QuestionGridState();
}

class _QuestionGridState extends State<QuestionGrid> {
  late List<CustomQuestionOverview> question_overview;

  @override
  void initState() {
    super.initState();
    question_overview = widget.question_overview;
  }

  Future _submitQuiz() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff01020a),
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Are you sure you want to submit?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                TextButton(
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                TextButton(
                  child: const Text(
                    'Yes',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onPressed: () async {
                    final McqToken = await widget.storage.read(key: 'mcqtoken');
                    final McqId =
                        await widget.storage.read(key: 'mcqId').toString();
                    Map<String, String> headers = {
                      'Authorization': 'Token ${McqToken}',
                    };
                    try {
                      final url = Uri.parse(Constants.SUBMIT_MCQ + (McqId));
                      final response = await http.get(
                        url,
                        headers: headers,
                      );
                      if (response.statusCode == 200) {
                        var result = jsonDecode(response.body);
                        log(result.toString());
                        Fluttertoast.showToast(
                          msg: "Submit Successful",
                          backgroundColor: Colors.blue.shade600,
                        );
                        while (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      } else {
                        var result = jsonDecode(response.body);
                        log(result.toString());
                        var error = result['error'] ??
                            'There is some problem currently';
                        throw error;
                      }
                    } catch (error) {
                      Fluttertoast.showToast(
                        msg: error.toString(),
                        backgroundColor: Colors.blue.shade600,
                      );
                      while (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xff1b3357),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.41,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      _submitQuiz();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 228, 29, 95),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (2 / 100),
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    children: question_overview,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
