import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../event_slots/logic/booked_slot_cubit.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

class MyTicketView extends StatelessWidget {
  final String name;
  final String description;
  final String isBooked;
  const MyTicketView({
    super.key,
    required this.name,
    this.description = "",
    this.isBooked = "",
  });

  Widget EventSlot(
    double h,
    double w,
    String slot,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          (h * 0.09),
        ),
        color: Colors.white38,
      ),
      child: Center(
        child: Text(
          slot,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      height: h * 0.14,
      width: w * 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventSlotsCubit>(context).getBookingDetails();

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var th = height / 2.4;
    var tw = width / 1.2;

    return Padding(
      padding: EdgeInsets.all(tw / 19),
      child: TicketWidget(
        width: tw,
        height: th,
        color: Colors.transparent,
        isCornerRounded: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(th * 0.07),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueGrey.withOpacity(0.3),
                Colors.blueGrey.withOpacity(0.5),
                // Colors.white24,
                // Colors.white24,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: height / 35, left: width / 22),
            child: SizedBox(
              height: th,
              width: tw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: th / 28,
                      left: tw / 25,
                      right: tw / 15,
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: tw / 6.5,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: th / 50, left: tw / 25),
                    child: Text(
                      "TECH",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: tw / 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: th / 50,
                      left: tw / 110,
                      right: tw / 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: th / 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: th * 0.11,
                        ),
                        DottedLine(
                          lineThickness: tw / 130,
                          dashGapLength: tw / 40,
                          dashLength: tw / 25,
                        ),
                        Container(
                          margin: EdgeInsets.all(tw / 15),
                          child: BlocConsumer<EventSlotsCubit,
                              EventSlotStateCubit>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              print(state.toString());

                              return state is BookedSlotState
                                  ? Text(
                                      "Date: ....... Time: ........",
                                      style: TextStyle(
                                        fontSize: tw / 25,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "Registered : You haven't booked a slot for this event",
                                      style: TextStyle(
                                        fontSize: tw / 25,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                            },
                          ),
                        ),
                        Center(
                          child: Card(
                            shadowColor: Colors.black,
                            color: Colors.black26,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: BlocConsumer<EventSlotsCubit,
                                EventSlotStateCubit>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return state is BookedSlotState
                                    ? TextButton(
                                        onPressed: () {
                                          // nav to aditi's page
                                        },
                                        child: const Text(
                                          'View Details',
                                          style: TextStyle(
                                            fontFamily: 'QuickSand',
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          // nav to soumya's page
                                        },
                                        child: const Text(
                                          'Book Slot',
                                          style: TextStyle(
                                            fontFamily: 'QuickSand',
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
