import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/features/home_page/logic/event_details_cubit_cubit.dart';
import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';

class ViewSlotDetails extends StatefulWidget {
  final int id;
  final String name;

  ViewSlotDetails({
    Key? key,
    required this.id,
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
            return Panorama(
              sensitivity: 0.4,
              animSpeed: 0.5,
              sensorControl:
                  state ? SensorControl.Orientation : SensorControl.None,
              child: Image.asset(
                AppImages.spaceBackground,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<EventDetailsCubitCubit, EventDetailsCubitState>(
            listener: (context, state) {},
            builder: (context, state) {
              log(state.toString());
              if (state is EventDetailsCubitLoading) {
                return Center(
                  child: Center(
                    child: Lottie.asset(AppImages.loadingAnimation),
                  ),
                );
              } else if (state is EventDetailsCubitLoaded) {
                final bookedSlotModel = state.events.events!
                    .where((element) => element.id == widget.id)
                    .first;

                return GlassmorphicContainer(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 60,
                    bottom: 60,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenheight * 0.1,
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
                            imageUrl: bookedSlotModel.logo!,
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
                        height: screenheight * 0.1,
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
                                  bookedSlotModel.name ?? '',
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
                              padding: const EdgeInsets.only(left: 32, top: 20),
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
                                      DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(
                                          bookedSlotModel.createdAt ?? '',
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'QuickSand',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${DateTime.parse(bookedSlotModel.createdAt!).hour} - ${DateTime.parse(bookedSlotModel.updatedAt!).hour}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenheight * 0.02),
                            Padding(
                              padding: const EdgeInsets.only(left: 32, top: 20),
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
                                        fontFamily: 'QuickSand',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
