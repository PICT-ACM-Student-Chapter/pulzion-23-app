import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/images.dart';

import '../../../../constants/models/cart_model.dart';
import '../../../../constants/styles.dart';
import 'cart_list_tile.dart';

class CartPageContent extends StatelessWidget {
  final CartItemList? eventList;
  const CartPageContent(this.eventList, {super.key});

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
                          "TOTAL : ₹${eventList == null || eventList!.cartItems == null ? 0 : eventList!.cartItems!.fold(0, (previousValue, element) => previousValue + element.price!)} ",
                          style: AppStyles.bodyTextStyle3().copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "(${eventList == null || eventList!.cartItems == null ? 0 : eventList!.cartItems!.length} items)",
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
          child: eventList == null || eventList!.cartItems == null
              ? Center(
                  child: Text(
                    "Cart is empty.",
                    style: AppStyles.bodyTextStyle3().copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  "Items",
                                  style: AppStyles.bodyTextStyle2().copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              CartListTile(eventList!.cartItems![index]),
                            ],
                          )
                        : CartListTile(
                            eventList!.cartItems![index],
                          );
                  },
                  itemCount: eventList!.cartItems!.length,
                ),
        ),
      ],
    );
  }
}
