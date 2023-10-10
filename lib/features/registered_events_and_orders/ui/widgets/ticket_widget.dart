import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/config/size_config.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';
import 'package:pulzion23/features/event_slots/ui/booked_window.dart';
import 'package:pulzion23/features/event_slots/ui/view_slot_details.dart';
import 'package:pulzion23/features/registered_events_and_orders/cubit/registered_events_and_orders_cubit.dart';
import '../../../event_slots/logic/booked_slot_cubit.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyTicketView extends StatelessWidget {
  final String name;
  final String? description;
  final int? isBooked;
  final String? eventType;
  final int? id;
  final String? logo;

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
    required this.isBooked,
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
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.overlay,
              ),
              image: const AssetImage(
                "assets/images/ticket2.jpeg",
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: (th * 0.5 - 75) * 0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (logo != null)
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CachedNetworkImage(
                            imageUrl: logo!,
                            color: Colors.black,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Container(),
                            cacheManager: _cacheManager,
                            fadeInDuration: const Duration(milliseconds: 100),
                            fit: BoxFit.fitWidth,
                            key: UniqueKey(),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: tw / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (id == null)
                            SizedBox(
                              width: tw * 0.65,
                              child: Text(
                                'Combo',
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: AppStyles.NormalText().copyWith(
                                  fontSize:
                                      SizeConfig.getProportionateScreenFontSize(
                                    25,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          SizedBox(
                            width: tw * 0.65,
                            child: Text(
                              name,
                              softWrap: true,
                              textAlign: id == null ? TextAlign.center : null,
                              style: AppStyles.NormalText().copyWith(
                                fontSize:
                                    SizeConfig.getProportionateScreenFontSize(
                                  20,
                                ),
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (eventType != null)
                            Text(
                              eventType!,
                              style: AppStyles.NormalText().copyWith(
                                fontSize:
                                    SizeConfig.getProportionateScreenFontSize(
                                  17,
                                ),
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (id == null) SizedBox(height: th * 0.005),
              DottedLine(
                lineThickness: tw / 170,
                dashGapLength: tw / 50,
                dashLength: tw / 30,
                dashColor: Colors.black.withOpacity(0.7),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: isBooked != null
                    ? Text(
                        "You have booked slot for this event",
                        style: AppStyles.NormalText().copyWith(
                          fontSize: SizeConfig.getProportionateScreenFontSize(
                            20,
                          ),
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        id == null
                            ? "You have booked this combo"
                            : "Registered : You haven't booked a slot for this event",
                        style: AppStyles.NormalText().copyWith(
                          fontSize: SizeConfig.getProportionateScreenFontSize(
                            13,
                          ),
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              if (id != null)
                Container(
                  // margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(10),
                  width: tw * 0.6,
                  height: th * 0.2,

                  child: HalloweenButton(
                    color: Colors.black,
                    isColor: true,
                    buttonText: isBooked != null ? 'View Details' : 'Book Slot',
                    icon: isBooked != null
                        ? Icons.remove_red_eye_rounded
                        : Icons.pin_drop_rounded,
                    onPressed: () {
                      isBooked != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      RegisteredEventsAndOrdersCubit()
                                        ..getOnlyRegisteredEvents(),
                                  child: ViewSlotDetails(
                                    id: id!,
                                    logo: logo!,
                                    name: name,
                                  ),
                                ),
                              ),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) => EventSlotsCubit()
                                        ..getAvailableSlots(id!),
                                    ),
                                    BlocProvider.value(
                                      value: BlocProvider.of<
                                          RegisteredEventsAndOrdersCubit>(
                                        context,
                                      ),
                                    ),
                                  ],
                                  child: BookSlots(
                                    id: id!,
                                    name: name,
                                    logo: logo!,
                                  ),
                                ),
                              ),
                            );
                    },
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Icon(
                    //       isBooked != null
                    //           ? Icons.remove_red_eye_rounded
                    //           : Icons.pin_drop_rounded,
                    //       color: Colors.white,
                    //     ),
                    //     Text(
                    //       isBooked != null ? 'View Details' : 'Book Slot',
                    //       style: const TextStyle(
                    //         color: Colors.white,
                    //         fontFamily: 'QuickSand',
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
