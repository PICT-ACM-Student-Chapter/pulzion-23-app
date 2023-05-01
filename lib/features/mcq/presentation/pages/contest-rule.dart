import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:panorama/panorama.dart';
import 'package:provider/provider.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/constants/widgets/error_dialog.dart';
import 'package:pulzion23/features/mcq/presentation/pages/questionPageBuilder.dart';
// import 'package:pulzion22_app/screens/mcq/questionPageBuilder.dart';
// import '../../constants/constants.dart';
// import '../../services/mcq_user_provider.dart';

// ignore_for_file:prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import '../../../../constants/images.dart';
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

  bool _isError = false;

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
        setState(() {
          _isError = true;
        });
        var result = jsonDecode(response.body);
        var error = result['error'] ?? 'There is some problem currently';
        throw error;
      }
    } catch (error) {
      setState(() {
        _isError = true;
      });
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
    return _isError
        ? Scaffold(
            backgroundColor: Colors.white.withOpacity(0.15),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            body: Center(
              child: ErrorDialog('Response already submitted.'),
            ),
          )
        : _isLoad
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: Colors.white.withOpacity(0.15),
                body: Center(
                  child: RuleBox(
                    id: widget.id,
                    isFinished: McqStatus.finished as bool,
                    endTime: DateTime.parse(McqStatus.fkEvent!.endTime as String),
                  ),
                ),
              );
  }
}

// ignore: must_be_immutable
class RuleBox extends StatelessWidget {
  final bool isFinished;
  final String id;
  final DateTime endTime;

  const RuleBox({Key? key, required this.id, required this.isFinished, required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(DateTime.parse(McqStatus.fkEvent!.endTime as String).toString());
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Rules",
            style: AppStyles.bodyTextStyle4(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "1. You cannot change apps after you begin with the quiz!",
                    style: AppStyles.bodyTextStyle3(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "2. Tabs cannot be changed during the quiz!, or you will be disqualified! , and the test will get autosubmitted!",
                    style: AppStyles.bodyTextStyle3(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "3.The duration of the quiz is for x mins and there are x questions! that are to be completed within the time limit! , if you fail to complete the quiz within the time limit , the test will record the responses submitted during the quiz and will be submitted automatically!",
                    style: AppStyles.bodyTextStyle3(),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                            timer: endTime.difference(DateTime.now()).inSeconds,
                          ),
                        ),
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
          ),
        ],
      ),
    );
  }
}
