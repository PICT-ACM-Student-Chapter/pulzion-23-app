import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/styles.dart';
import '../../../constants/models/slot_model.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/features/event_slots/logic/booked_slot_cubit.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class BookSlots extends StatelessWidget {
  final int id;
  final String name;
  final String logo;

  final _cacheManager = CacheManager(Config(
    'my_custom_cache_key',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));

  BookSlots({
    super.key,
    required this.id,
    required this.name,
    required this.logo,
  });

  // Widget gradientContainer(Widget child, double h, double w) {
  //   return Container(
  //     height: h,
  //     width: w,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: h * 0.025,
  //       vertical: w * 0.0075,
  //     ),
  //     padding: EdgeInsets.symmetric(
  //       horizontal: w * 0.025,
  //       vertical: h * 0.015,
  //     ),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //         colors: AppColors.eventCardGradientList.elementAt(
  //           0 %
  //               // orders[index].id! %
  //               AppColors.eventCardGradientList.length,
  //         ),
  //       ),
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(20),
  //       ),
  //       border: const Border.fromBorderSide(
  //         BorderSide(
  //           color: AppColors.cardBorder,
  //           width: 0.2,
  //         ),
  //       ),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(20),
  //       child: child,
  //     ),
  //   );
  // }

  Widget slotContainer(BuildContext ctx, Slot slot) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(slot.created_at!)),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
              Text(
                'Capacity: ${slot.capacity}',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.white,
            thickness: 0.3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Time: ${DateTime.parse(slot.created_at!).hour} - ${DateTime.parse(slot.end_time!).hour}',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
              Container(
                height: MediaQuery.of(ctx).size.height / 15,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xff07f49e), Color(0xff42047e)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextButton(
                    child: const Text(
                      'Book Slot',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'QuickSand',
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<EventSlotsCubit>(ctx)
                          .bookSlot(
                            id.toString(),
                            slot.id.toString(),
                          )
                          .then((value) {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

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
        SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: h / 4.5,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'BOOK SLOTS',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Panther',
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: FittedBox(
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl: logo,
                                        placeholder: (context, url) =>
                                            Container(),
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
                              SizedBox(
                                width: w / 25,
                              ),
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Panther',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    background: Container(
                      width: w / 4,
                      height: w / 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: AppColors.eventCardGradientList.elementAt(
                            0 % AppColors.eventCardGradientList.length,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: h * 0.02,
                              ),
                              SizedBox(
                                height: h * 0.8,
                                child: BlocConsumer<EventSlotsCubit,
                                    EventSlotStateCubit>(
                                  listener: (context, state) {
                                    if (state is BookingSuccessful) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        duration: Duration(seconds: 3),
                                        content:
                                            Text('Slot Booked Successfully!'),
                                        backgroundColor: Colors.green,
                                      ));
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is EventSlotLoadingState) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state is NotBookedSlotState) {
                                      return ListView.builder(
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.white10,
                                                  Colors.white30,
                                                ],
                                              ),
                                            ),
                                            height: h * 0.2,
                                            width: w,
                                            child: slotContainer(
                                              context,
                                              state.slot_list.slots![index],
                                            ),
                                          ),
                                        ),
                                        itemCount:
                                            state.slot_list.slots!.length,
                                      );
                                    } else if (state is EventSlotErrorState) {
                                      return Center(
                                        child: Text(
                                          'Error Occured',
                                          style: AppStyles.bodyTextStyle2()
                                              .copyWith(color: Colors.white),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: Text(
                                          'No Slots Available',
                                          style: AppStyles.bodyTextStyle2()
                                              .copyWith(color: Colors.white),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
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
      ],
    );
  }
}
