import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/features/event_slots/ui/booked_window.dart';
import 'package:pulzion23/features/event_slots/ui/view_slot_details.dart';
import '../../../event_slots/logic/booked_slot_cubit.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyTicketView extends StatelessWidget {
  final String name;
  final String description;
  final String isBooked;
  final String eventType;
  final int id;
  final String logo;

  final _cacheManager = CacheManager(Config(
    'my_custom_cache_key',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));

  MyTicketView({
    super.key,
    required this.name,
    required this.description,
    required this.eventType,
    required this.id,
    required this.logo,
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
      height: h * 0.14,
      width: w * 0.4,
      child: Center(
        child: Text(
          slot,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<EventSlotsCubit>(context).getBookingDetails();

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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: FittedBox(
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: logo,
                                  placeholder: (context, url) => Container(),
                                  errorWidget: (context, url, error) =>
                                      Container(),
                                  cacheManager: _cacheManager,
                                  fadeInDuration:
                                      const Duration(milliseconds: 100),
                                  fit: BoxFit.fitWidth,
                                  key: UniqueKey(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: th / 50, left: tw / 25),
                        child: Text(
                          eventType,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: tw / 17,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
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
                          height: th * 0.07,
                        ),
                        DottedLine(
                          lineThickness: tw / 170,
                          dashGapLength: tw / 50,
                          dashLength: tw / 30,
                          dashColor: Colors.white.withOpacity(0.5),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: tw / 15,
                            bottom: tw / 15,
                            left: tw / 30,
                            right: tw / 15,
                          ),
                          child: BlocConsumer<EventSlotsCubit,
                              EventSlotStateCubit>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return state is BookedSlotState
                                  ? Text(
                                      "Slot Booking not yet started",
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
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.05,
                            ),
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
                                  // if (state is EventSlotLoadingState) {
                                  //   return const Center(
                                  //     child: CircularProgressIndicator(),
                                  //   );
                                  // }
                                  if (state is BookedSlotState) {
                                    return TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewSlotDetails(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'View Details',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    );
                                  } else {
                                    return TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  EventSlotsCubit()
                                                    ..getAvailableSlots(id),
                                              child: BookSlots(
                                                id: id,
                                                name: name,
                                                logo: logo,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Book Slot',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'QuickSand'),
                                      ),
                                    );
                                  }
                                },
                              ),
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
