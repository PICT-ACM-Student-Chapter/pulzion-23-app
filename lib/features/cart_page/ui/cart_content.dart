import 'package:flutter/material.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:pulzion23/features/cart_page/ui/card_list_tile.dart';

import '../../../constants/images.dart';
import '../../../constants/styles.dart';

class CartPageContent extends StatelessWidget {
  final List<Events> eventList;
  const CartPageContent(this.eventList, {super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36.0, bottom: 26),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xff124567,
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                          AppImages.spaceBackground,
                        ),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff124567).withOpacity(0.7),
                          spreadRadius: 3,
                          blurRadius: 9,
                          offset: const Offset(0, -4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: h / 12,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "TOTAL : 80 ",
                                      style: AppStyles.bodyTextStyle3().copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 8.0),
                                  //   child: Row(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.end,
                                  //     children: [
                                  //       Text(
                                  //         "80",
                                  //         style: AppStyles.bodyTextStyle3(),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.009,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "(${eventList.length} items)",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                      colors: [Color(0xff07f49e), Color(0xff42047e)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Checkout  ",
                                      style: AppStyles.bodyTextStyle3().copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Divider(
                  height: 20,
                  thickness: 2.5,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.grey,
                ),
              ),
              Column(
                children: List.generate(
                  2,
                  (index) {
                    return index == 0
                        ? Column(children: [
                            const SizedBox(height: 20),
                            Text(eventList[index].mode!,
                                style: AppStyles.bodyTextStyle3().copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                            CartListTile(eventList[index])
                          ])
                        : CartListTile(eventList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
