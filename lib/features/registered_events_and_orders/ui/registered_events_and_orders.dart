import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../config/size_config.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/models/registered_event.dart';
import '../../../constants/styles.dart';
import '../../../constants/widgets/error_dialog.dart';
import '../cubit/registered_events_and_orders_cubit.dart';
import 'widgets/past_orders_card.dart';
import 'widgets/registered_events_cards.dart';

class RegisteredEventsAndOrders extends StatefulWidget {
  const RegisteredEventsAndOrders({super.key});

  @override
  State<RegisteredEventsAndOrders> createState() =>
      _RegisteredEventsAndOrdersState();
}

class _RegisteredEventsAndOrdersState extends State<RegisteredEventsAndOrders>
    with TickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  List<dynamic> getEventNames(List<RegisteredEvent> registeredEvents) {
    List<dynamic> eventNames = [];
    for (RegisteredEvent event in registeredEvents) {
      if (event.status == "accepted") {
        eventNames += event.events ?? [];
      }
    }

    return eventNames;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // print("helo");

        return RegisteredEventsAndOrdersCubit()..getRegisteredEventsAndOrders();
      },
      child: BlocBuilder<RegisteredEventsAndOrdersCubit,
          RegisteredEventsAndOrdersState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case RegisteredEventsAndOrdersLoading:
              {
                return Center(child: Lottie.asset(AppImages.loadingAnimation));
              }
            case RegisteredEventsAndOrdersLoaded:
              {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Your Events",
                        style: AppStyles.bodyTextStyle2().copyWith(
                          fontSize:
                              SizeConfig.getProportionateScreenFontSize(30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: DefaultTabController(
                        length: 2,
                        child: TabBar(
                          labelPadding: const EdgeInsets.all(12),
                          controller: tabBarController,
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.loginPageAccent,
                              ),
                            ),
                          ),
                          unselectedLabelColor: AppColors.cardSubtitleTextColor,
                          labelColor: AppColors.loginPageAccent,
                          tabs: [
                            Text(
                              'Registered Events',
                              style: TextStyle(
                                fontSize:
                                    SizeConfig.getProportionateScreenFontSize(
                                  12,
                                ),
                              ),
                            ),
                            Text(
                              'Past Orders',
                              style: TextStyle(
                                fontSize:
                                    SizeConfig.getProportionateScreenFontSize(
                                  12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: tabBarController,
                        children: [
                          RegisteredEventsCards(
                            registeredEvents:
                                (state as RegisteredEventsAndOrdersLoaded)
                                    .registeredEvents
                                    .toList(),
                          ),
                          PastOrdersCards(
                            (state).registeredOrders.toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            case RegisteredEventsAndOrdersError:
              {
                return ErrorDialog(
                  (state as RegisteredEventsAndOrdersError).errorMessage,
                  refreshFunction: () {
                    log("refreshing");
                    context
                        .read<RegisteredEventsAndOrdersCubit>()
                        .getRegisteredEventsAndOrders();
                  },
                );
              }
            default:
              {
                return Center(child: Lottie.asset(AppImages.loadingAnimation));
              }
          }
        },
      ),
    );
  }
}
