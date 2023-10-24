import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/mcqcolors.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/mcq/features/event_list/ui/contest-rule.dart';
import 'package:pulzion23/features/mcq/features/event_list/logic/cubit/mcq_event_list_cubit.dart';
import 'package:pulzion23/features/mcq/models/mcq_event_model.dart';

class McqEventList extends StatelessWidget {
  const McqEventList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EventListCubit>().loadEventPage();

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.15),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Event List',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Danger-Night',
            color: Color.fromRGBO(228, 176, 77, 1),
          ),
          textScaleFactor: 4.0,
        ),
      ),
      body: BlocBuilder<EventListCubit, EventListState>(
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
                  return MCQList.mcqEventList.isEmpty
                      ? const Center(
                          child: Text("No events available to play right now!"),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
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
                                color: Color.fromARGB(255, 123, 71, 16),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        MCQList.mcqEventList[i].fkEvent!.name
                                            as String,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                      ),
                                      MCQList.mcqEventList[i].started == true
                                          ? Text(
                                              'Started',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
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
                                    height: MediaQuery.of(context).size.height *
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
                                          color:
                                              Color.fromRGBO(228, 176, 77, 1),
                                        ),
                                      ),
                                      Text(
                                        'End Time',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.022,
                                          color:
                                              Color.fromRGBO(228, 176, 77, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        DateFormat('dd E  kk:mm a')
                                            .format(DateTime.parse(MCQList
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
                                            .format(DateTime.parse(MCQList
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
                itemCount: MCQList.mcqEventList.length,
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
          } else
            return Container();
        },
      ),
    );
  }
}
