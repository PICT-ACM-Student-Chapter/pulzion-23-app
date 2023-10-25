import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/constants/widgets/empty_page.dart';
import 'package:pulzion23/features/event_slots/ui/view_slot_details.dart';
import 'package:pulzion23/features/registered_events_and_orders/cubit/registered_events_and_orders_cubit.dart';
import '../../../constants/models/slot_model.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/features/event_slots/logic/booked_slot_cubit.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lottie/lottie.dart';

class BookSlots extends StatefulWidget {
  final int id;
  final String name;
  final String logo;

  const BookSlots({
    super.key,
    required this.id,
    required this.name,
    required this.logo,
  });

  @override
  State<BookSlots> createState() => _BookSlotsState();
}

class _BookSlotsState extends State<BookSlots> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  final _cacheManager = CacheManager(Config(
    'my_custom_cache_key',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));

  Widget slotContainer(BuildContext ctx, Slot slot) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(slot.created_at!))}',
                      style: AppStyles.NormalText()
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      'Capacity: ${slot.capacity}',
                      style: AppStyles.NormalText()
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 0.3,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Time: ',
                      style: AppStyles.NormalText()
                          .copyWith(fontSize: 15, color: Colors.white),
                      children: [
                        TextSpan(
                          text:
                              '${DateFormat('hh:mm a').format(DateTime.parse(slot.start_time!))} - ${DateFormat('hh:mm a').format(DateTime.parse(slot.end_time!))}',
                          style: AppStyles.NormalText()
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: MediaQuery.of(ctx).size.height / 15,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                        color: Colors.orange[700]!.withOpacity(0.8),
                        width: 0.7,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.0,
                          spreadRadius: 2.0,
                          color: Colors.yellow[900]!.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: TextButton(
                      child: Text(
                        'Book Slot',
                        style: AppStyles.NormalText()
                            .copyWith(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        BlocProvider.of<EventSlotsCubit>(ctx)
                            .bookSlot(
                              widget.id.toString(),
                              slot.id.toString(),
                            )
                            .then((value) {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
            return Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        SafeArea(
          top: true,
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
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: h / 20,
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                'BOOK SLOTS',
                                style: AppStyles.NormalText().copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: FittedBox(
                                    child: CachedNetworkImage(
                                      imageUrl: widget.logo,
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
                                SizedBox(
                                  width: w / 25,
                                ),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text(
                                      widget.name,
                                      style: AppStyles.TitleText().copyWith(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w100,
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
                    background: Container(
                      width: w / 4,
                      height: w / 4,
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
                        // border: Border.all(
                        //   color: Colors.orange[700]!.withOpacity(0.8),
                        //   width: 0.7,
                        // ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            spreadRadius: 2.0,
                            color: Colors.yellow[900]!.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocConsumer<EventSlotsCubit, EventSlotStateCubit>(
                  listener: (context, state) {
                    if (state is BookingSuccessful) {
                      BlocProvider.of<RegisteredEventsAndOrdersCubit>(context)
                          .getUpdatedEvents(context);

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(
                          'Slot Booked Successfully!',
                          style: AppStyles.NormalText().copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 196, 117, 15),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<RegisteredEventsAndOrdersCubit>(
                            create: (context) =>
                                RegisteredEventsAndOrdersCubit()
                                  ..getOnlyRegisteredEvents(),
                            child: ViewSlotDetails(
                              id: widget.id,
                              logo: widget.logo,
                              name: widget.name,
                            ),
                          ),
                        ),
                      );
                    } else if (state is EventSlotErrorState) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(
                          state.message.toString(),
                          style: AppStyles.NormalText().copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: const Color.fromARGB(255, 78, 48, 21),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is EventSlotLoadingState) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: w / 2.5,
                              ),
                              Lottie.asset(
                                AppImages.loader,
                                height: w / 2,
                                width: w / 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is NotBookedSlotState) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                top: 10.0,
                                bottom: 8.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
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
                            );
                          },
                          childCount: state.slot_list.slots!.length,
                        ),
                      );
                    } else if (state is EventSlotErrorState) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: w / 2.5,
                              ),
                              EmptyPage(
                                title: 'Error',
                                errorMessage: state.message.toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is NoAvailableSlots) {
                      return SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(
                              height: w / 2.5,
                            ),
                            const EmptyPage(
                              errorMessage:
                                  'Slot Booking isn\'t active for this event! \nFurther details will be communicated to you via email in due course.',
                              title: 'Slots Unavailable',
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Center(
                            child: Lottie.asset(AppImages.loadingAnimation),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
