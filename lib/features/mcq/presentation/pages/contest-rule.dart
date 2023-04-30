import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pulzion23/features/mcq/presentation/pages/questionPageBuilder.dart';
// import 'package:pulzion22_app/screens/mcq/questionPageBuilder.dart';
// import '../../constants/constants.dart';
// import '../../services/mcq_user_provider.dart';

// ignore_for_file:prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import '../../../../constants/mcqconstants.dart';
import '../../../../services/mcq_user_provider.dart';
import 'mcq_event_statusmodel.dart';

class RulePage extends StatefulWidget {
  final String id;

  const RulePage({Key? key, required this.id}) : super(key: key);

  @override
  State<RulePage> createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  bool isfinished = false;

  bool _isLoad = true;

  Future _getMCQEventDetails() async {
    var _mcqUser = Provider.of<MCQUserProvider>(context, listen: false);

    Map<String, String> headers = {
      'Authorization': 'Token ${_mcqUser.mcqtoken}',
    };
    try {
      final url = Uri.parse(Constants.GET_MCQ_EVENT_DETAILS + widget.id);
      final response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        _mcqUser.setId(widget.id);
        var result = await jsonDecode(response.body);
        McqStatus.clearFunction();
        McqStatus.fromJson(result);
        setState(() {
          _isLoad = false;
        });
      } else {
        var result = jsonDecode(response.body);
        var error = result['error'] ?? 'There is some problem currently';
        throw error;
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.blue.shade600,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMCQEventDetails();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoad
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            extendBodyBehindAppBar: true,
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/backImage.png"),
                      fit: BoxFit.cover)),
              child: ListView(children: [
                RuleBox(
                  id: widget.id,
                  isFinished: McqStatus.finished as bool,
                  endTime: DateTime.parse(McqStatus.fkEvent!.endTime as String),
                ),
              ]),
            ),
          );
  }
}

// ignore: must_be_immutable
class RuleBox extends StatelessWidget {
  final bool isFinished;
  final String id;
  final DateTime endTime;

  RuleBox(
      {Key? key,
      required this.id,
      required this.isFinished,
      required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Colors.black54,
            Color(0xFF2d4c6a),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Color(0xFF2d4c6a),
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.white,
                  //   blurRadius: 5.0, // soften the shadow
                  //   spreadRadius: 3.0, //extend the shadow
                  //   offset: Offset(
                  //     2.0, // Move to right 10  horizontally
                  //     2.0, // Move to bottom 10 Vertically
                  //   ),
                  // )
                ]),
            child: Center(
              child: Text(
                "Rules",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              children: [
                Padding(
                  //dummy rules
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "1. You cannot change apps after you begin with the quiz!",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "2. Tabs cannot be changed during the quiz!, or you will be disqualified! , and the test will get autosubmitted!",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "3.The duration of the quiz is for x mins and there are x questions! that are to be completed within the time limit! , if you fail to complete the quiz within the time limit , the test will record the responses submitted during the quiz and will be submitted automatically!",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //
                    // primary:Color.fromARGB(255, 36, 69, 119),
                    // primary: Color(0xff0a3b58),
                    primary: const Color(0xFF031F4B),
                    // primary: const Color(0xff1b3357),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () {
                    if (isFinished) {
                      Fluttertoast.showToast(
                        msg: "Sorry the event has ended!",
                        backgroundColor: Colors.blue.shade600,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Quiz begins!",
                        backgroundColor: Colors.blue.shade600,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleQuestion(
                                  id: id,
                                  timer: endTime
                                      .difference(DateTime.now())
                                      .inSeconds,
                                )),
                      );
                    }
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
