import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../constants/models/registered_event.dart';
import 'package:intl/intl.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/styles.dart';
import '../../../../constants/widgets/empty_page.dart';

class PastOrdersCards extends StatelessWidget {
  final List<RegisteredEvent> orders;
  const PastOrdersCards(this.orders, {super.key});

  @override
  Widget build(BuildContext context) {
    log(orders.toString());
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return orders.isEmpty
        ? const Center(
          child: EmptyPage(
            errorMessage: 'No pending / Rejected orders',
            title: 'No Previous Orders',
          ),
        )
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Color statusColor = orders[index].status == "rejected" ? Colors.red : Colors.yellow;

              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: w * 0.025,
                  vertical: h * 0.0075,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.025,
                  vertical: h * 0.015,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppColors.eventCardGradientList.elementAt(
                      orders[index].id! % AppColors.eventCardGradientList.length,
                    ),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: const Border.fromBorderSide(
                    BorderSide(
                      color: AppColors.cardBorder,
                      width: 0.2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2.0,
                                ),
                                child: Text(
                                  'Transaction ID: ${orders[index].transactionId}',
                                  style: AppStyles.bodyTextStyle3().copyWith(
                                    color: statusColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2.0,
                                ),
                                child: Text(
                                  DateFormat("hh:mm, dd MMMM yyyy")
                                      .format(orders[index].createdAt!),
                                  style: AppStyles.bodyTextStyle3().copyWith(
                                    color: AppColors.loginPageAccent,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ] +
                            List.generate(
                              orders[index].events!.length,
                              (index1) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2.0,
                                ),
                                child: Text(
                                  orders[index].events![index1],
                                  style: AppStyles.bodyTextStyle3().copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "₹${orders[index].amount.toString()}",
                          style: AppStyles.bodyTextStyle3().copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          (orders[index].status ?? "Rejected").toUpperCase(),
                          style: AppStyles.bodyTextStyle3().copyWith(
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
