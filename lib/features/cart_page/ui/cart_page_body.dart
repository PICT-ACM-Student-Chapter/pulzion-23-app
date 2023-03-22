import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/models/event_model.dart';

import '../../../constants/styles.dart';
import 'cart_list_tile.dart';

class CartPageContent extends StatelessWidget {
  final EventList eventList;
  late final List<Events> techEventsList;
  late final List<Events> nonTechEventsList;
  CartPageContent(this.eventList, {super.key}) {
    techEventsList = eventList.events!.where((element) => element.type == 'Technical').toList();
    nonTechEventsList =
        eventList.events!.where((element) => element.type == 'Non Technical').toList();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.1),
              height: h * 0.1,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    15,
                  ),
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h / 12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TOTAL : ₹${eventList.events!.fold(0, (previousValue, element) => previousValue + element.price!)} ",
                          style: AppStyles.bodyTextStyle3().copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "(${eventList.events!.length} items)",
                          style: AppStyles.bodyTextStyle3().copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xff07f49e), Color(0xff42047e)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Checkout",
                            style: AppStyles.bodyTextStyle3().copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -h * 0.05,
              left: w * 0.025,
              child: Lottie.asset(
                AppImages.orangeRocket,
                fit: BoxFit.cover,
                height: 0.1,
                width: w * 0.2,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Technical Events",
                        style: AppStyles.bodyTextStyle2().copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CartListTile(techEventsList[index]),
                  ],
                );
              } else if (index < techEventsList.length) {
                return CartListTile(techEventsList[index]);
              } else if (index == techEventsList.length) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Non Technical Events",
                        style: AppStyles.bodyTextStyle2().copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    CartListTile(nonTechEventsList[index - techEventsList.length]),
                  ],
                );
              } else if (index < techEventsList.length + nonTechEventsList.length) {
                return CartListTile(nonTechEventsList[index - techEventsList.length]);
              } else {
                return Container();
              }
            },
            itemCount: eventList.events!.length,
          ),
        ),
      ],
    );
  }
}
