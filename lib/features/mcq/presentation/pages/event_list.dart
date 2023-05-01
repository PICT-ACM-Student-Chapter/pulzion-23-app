import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:panorama/panorama.dart';
import 'package:provider/provider.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/styles.dart';
// import 'package:pulzion22_app/screens/mcq/contest-rule.dart';
// import 'package:pulzion22_app/screens/mcq/mcq_event_model.dart';
// import 'package:pulzion22_app/services/mcq_user_provider.dart';

import '../../../../constants/images.dart';
import '../../../../constants/mcqcolors.dart';
import '../../../../constants/mcqconstants.dart';
import '../../../../project/cubit/animation_toggle_cubit.dart';
import '../../../../services/mcq_user_provider.dart';
// import '../../constants/constants.dart';
// import '../../theme/app_colors.dart';
import 'contest-rule.dart';
import 'mcq_event_model.dart';

class MCQEventList extends StatefulWidget {
  const MCQEventList({Key? key}) : super(key: key);

  @override
  State<MCQEventList> createState() => _MCQEventListState();
}

class _MCQEventListState extends State<MCQEventList> {
  bool _isLoad = true;

  Future _getMCQEventList() async {
    var _mcqUser = Provider.of<MCQUserProvider>(context, listen: false);

    Map<String, String> headers = {
      'Authorization': 'Token ${_mcqUser.mcqtoken}',
    };
    try {
      final url = Uri.parse(Constants.GET_MCQ_EVENTS);
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        MCQList.mcqEventList.clear();
        MCQList.fromJson(result);
        setState(() {
          _isLoad = false;
        });
      } else {
        var result = jsonDecode(response.body);
        var error = result['error'] ?? 'There is some problem currently not possible!';
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
    super.initState();
    _getMCQEventList();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoad
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white.withOpacity(0.15),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Event List',
                style: AppStyles.bodyTextStyle2(),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.only(top: 50),
              child: ListView.separated(
                itemBuilder: (context, i) {
                  return MCQList.mcqEventList.isEmpty
                      ? const Center(
                          child: Text("No events available to play right now!"),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.02,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (MCQList.mcqEventList[i].started == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RulePage(
                                      id: MCQList.mcqEventList[i].id as String,
                                    ),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Event has not started yet!",
                                  backgroundColor: Colors.blue.shade600,
                                );
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.5),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    MediaQuery.of(context).size.width * 0.015,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        MCQList.mcqEventList[i].fkEvent!.name as String,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.03,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.018,
                                      ),
                                      MCQList.mcqEventList[i].started == true
                                          ? Text(
                                              'Started',
                                              style: TextStyle(
                                                fontSize:
                                                    MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.green,
                                              ),
                                            )
                                          : const Text(
                                              'Not Started',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.red,
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Start Time',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.022,
                                          color: MCQAppColors.COLOR_SWATCH2,
                                        ),
                                      ),
                                      Text(
                                        'End Time',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.022,
                                          color: MCQAppColors.COLOR_SWATCH2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        DateFormat('dd E  kk:mm a')
                                            .format(DateTime.parse(MCQList
                                                    .mcqEventList[i].fkEvent!.startTime as String)
                                                .toLocal())
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd E  kk:mm a')
                                            .format(DateTime.parse(MCQList
                                                    .mcqEventList[i].fkEvent!.endTime as String)
                                                .toLocal())
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: MCQList.mcqEventList.length,
              ),
            ),
          );
  }
}

// class Events {
//   final String id;
//   final String event_id;
//   final String name;
//   final String start;
//   final String end;
//   final String ems_event_id;
//   final String ems_slot_id;
//   final bool started;
//   const Events(this.name, this.start, this.end, this.id, this.ems_event_id,
//       this.ems_slot_id, this.event_id, this.started);
// }

// const Event_List = [
//   Events(
//       "Test event",
//       "2022-04-18T06:48:03Z",
//       "2022-04-20T06:48:07Z",
//       "a78c01c7-05e0-47fc-86da-a28cff53020b",
//       "dd9d8cf7-cc1d-4195-8b23-e9fe10be8604",
//       "1",
//       "3",
//       false),
//   Events(
//       "Test event",
//       "2022-04-18T06:48:03Z",
//       "2022-04-20T06:48:07Z",
//       "a78c01c7-05e0-47fc-86da-a28cff53020b",
//       "dd9d8cf7-cc1d-4195-8b23-e9fe10be8604",
//       "1",
//       "3",
//       false)
// ];
