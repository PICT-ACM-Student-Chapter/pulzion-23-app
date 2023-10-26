import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/mcq/features/event_list/ui/contest-rule.dart';
import 'package:pulzion23/features/mcq/features/event_list/logic/cubit/mcq_event_list_cubit.dart';
import 'package:pulzion23/features/mcq/features/mcq_login/logic/cubit/mcq_login_cubit.dart';
import 'package:pulzion23/features/mcq/models/mcq_event_model.dart';

class McqEventList extends StatelessWidget {
  const McqEventList({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Fluttertoast.showToast(
          msg: "Please Logout from MCQ Platform",
          backgroundColor: Colors.blue.shade600,
        );

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                final nv = Navigator.of(context);
                await context.read<McqLoginCubit>().logout();
                nv.pop();
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            "MCQ Events",
            style: AppStyles.TitleText().copyWith(
              fontSize: 50,
              fontWeight: FontWeight.w100,
            ),
          ),
          backgroundColor: const Color(0xff01020a),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BlocBuilder<EventListCubit, EventListState>(
              builder: (context, state) {
                if (state is EventPageLoading) {
                  return Center(
                    child: Center(
                      child: Lottie.asset(AppImages.loadingAnimation),
                    ),
                  );
                } else if (state is EventPageCurrentEvents) {
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: ListView.separated(
                      itemBuilder: (context, i) {
                        return state.mcqList.mcqEventList.isEmpty
                            ? const Center(
                                child: Text(
                                  "No events available to play right now!",
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05,
                                  vertical: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (state.mcqList.mcqEventList[i].started ==
                                        true) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                                EventListCubit()
                                                  ..getMCQEventDetails(state
                                                      .mcqList
                                                      .mcqEventList[i]
                                                      .id as String),
                                            child: RulePage(
                                              id: state.mcqList.mcqEventList[i]
                                                  .id as String,
                                            ),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.6),
                                          Colors.black.withOpacity(0.4),
                                          Colors.black.withOpacity(0.4),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.orange[700]!
                                            .withOpacity(0.8),
                                        width: 0.7,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1.0,
                                          spreadRadius: 2.0,
                                          color: Colors.yellow[900]!
                                              .withOpacity(0.3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              state.mcqList.mcqEventList[i]
                                                  .fkEvent!.name as String,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.03,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018,
                                            ),
                                            state.mcqList.mcqEventList[i]
                                                        .started ==
                                                    true
                                                ? Text(
                                                    'Started',
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.025,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Start Time',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.022,
                                                color: const Color.fromRGBO(
                                                    228, 176, 77, 1),
                                              ),
                                            ),
                                            Text(
                                              'End Time',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.022,
                                                color: const Color.fromRGBO(
                                                    228, 176, 77, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              DateFormat('dd E  kk:mm a')
                                                  .format(DateTime.parse(state
                                                          .mcqList
                                                          .mcqEventList[i]
                                                          .fkEvent!
                                                          .startTime as String)
                                                      .toLocal())
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd E  kk:mm a')
                                                  .format(DateTime.parse(state
                                                          .mcqList
                                                          .mcqEventList[i]
                                                          .fkEvent!
                                                          .endTime as String)
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
                      itemCount: state.mcqList.mcqEventList.length,
                    ),
                  );
                } else if (state is EventPageEmpty) {
                  return const Center(
                    child: Text("NO EVENTS PRESENT"),
                  );
                } else if (state is EventPageError) {
                  Fluttertoast.showToast(
                    msg: state.message.toString(),
                    backgroundColor: Colors.blue.shade600,
                  );

                  return const Center(
                    child: Text("Something Went Wrong"),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
