import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/models/booked_slot_model.dart';
import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pulzion23/features/registered_events_and_orders/cubit/registered_events_and_orders_cubit.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';

import '../../home_page/ui/wigets/custom_appbar.dart';

class ViewSlotDetails extends StatefulWidget {
  final int id;
  final String logo;
  final String name;

  const ViewSlotDetails({
    Key? key,
    required this.id,
    required this.logo,
    required this.name,
  }) : super(key: key);

  @override
  State<ViewSlotDetails> createState() => _TicketState();
}

class _TicketState extends State<ViewSlotDetails> {
  final _cacheManager = CacheManager(
    Config(
      'my_custom_cache_key',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        BlocConsumer<GlobalParameterCubit, bool>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (previous != current) {
              return true;
            }

            return false;
          },
          builder: (context, state) {
            return Image.asset(
              AppImages.spaceBackground2,
              fit: BoxFit.cover,
            );
          },
        ),
        Scaffold(
          appBar: const CustomAppBar(),
          backgroundColor: Colors.transparent,
          body: BlocConsumer<RegisteredEventsAndOrdersCubit,
              RegisteredEventsAndOrdersState>(
            listener: (context, state) {},
            builder: (context, state) {
              log(state.toString());
              if (state is RegisteredEventsAndOrdersLoading) {
                return Center(
                  child: Center(
                    child: Lottie.asset(AppImages.loadingAnimation),
                  ),
                );
              } else if (state is RegisteredEvents) {
                final BookedSlotModel bookedSlotModel = state.bookedEventList
                    .firstWhere((element) => element.id == widget.id);

                return GlassmorphicContainer(
                  margin: EdgeInsets.only(
                    left: screenheight * 0.05,
                    right: screenheight * 0.05,
                    bottom: screenheight * 0.1,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  blur: 0.2,
                  borderRadius: 20,
                  border: 2,
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0),
                      const Color((0xFFffffff)).withOpacity(0),
                    ],
                  ),
                  linearGradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.08),
                      const Color(0xFFffffff).withOpacity(0.08),
                    ],
                    stops: const [
                      0.1,
                      1,
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenheight * 0.05,
                        ),
                        Container(
                          padding: EdgeInsets.all(screenheight * 0.04),
                          height: screenheight * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.1),
                              ],
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CachedNetworkImage(
                              imageUrl: widget.logo,
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
                          height: screenheight * 0.05,
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    widget.name,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Panther',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenheight * 0.02,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: screenwidth * 0.01,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'Date',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.grey,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: screenwidth * 0.01,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'Time',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenheight * 0.005,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(
                                            bookedSlotModel.start_time ?? '',
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Colors.transparent,
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${DateFormat('hh:mm a').format(DateTime.parse(bookedSlotModel.start_time!))} - ${DateFormat('hh:mm a').format(DateTime.parse(bookedSlotModel.end_time!))}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenheight * 0.02),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.laptop,
                                      color: Colors.grey,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: screenwidth * 0.01,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'Mode',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.airplane_ticket,
                                      color: Colors.grey,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: screenwidth * 0.01,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'Ticket ID',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenheight * 0.005,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        bookedSlotModel.mode.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        bookedSlotModel.id.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'QuickSand',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: screenheight * 0.02,
                                    bottom: screenheight * 0.01,
                                  ),
                                  child: Lottie.asset(AppImages.orangeRocket),
                                ),
                              ),
                              const Text(
                                'Can\'t wait to see you at the event! Hope you have a great time!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'QuickSand',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
