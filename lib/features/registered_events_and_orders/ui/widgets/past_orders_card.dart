import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../constants/models/registered_event.dart';
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
              Color statusColor = Colors.yellow;
              if (orders[index].status?.toLowerCase() == "accepted") {
                statusColor = Colors.green.shade500;
              } else if (orders[index].status?.toLowerCase() == "rejected") {
                statusColor = Colors.red;
              }

              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: w * 0.05,
                  vertical: h * 0.02,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.025,
                  vertical: h * 0.015,
                ),
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
                  borderRadius: BorderRadius.circular(20),
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
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: AppColors.eventCardGradientList.elementAt(
                //       orders[index].id! %
                //           AppColors.eventCardGradientList.length,
                //     ),
                //   ),
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(20),
                //   ),
                //   border: const Border.fromBorderSide(
                //     BorderSide(
                //       color: AppColors.cardBorder,
                //       width: 0.2,
                //     ),
                //   ),
                // ),
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
                                  style: AppStyles.NormalText().copyWith(
                                    color: const Color.fromARGB(
                                        255, 208, 168, 116),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
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
                                  '- ${orders[index].events![index1]}',
                                  style: AppStyles.NormalText().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ) +
                            [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 8.0,
                                ),
                                child: orders[index].combos == null ||
                                        orders[index].combos!.isEmpty
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        child: Text(
                                          'Combos',
                                          style:
                                              AppStyles.NormalText().copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                              ),
                            ] +
                            List.generate(
                              orders[index].combos == null
                                  ? 0
                                  : orders[index].combos!.length,
                              (index2) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 2.0,
                                ),
                                child: Text(
                                  '- ${orders[index].combos![index2]}',
                                  style: AppStyles.NormalText().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
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
                          style: AppStyles.NormalText().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          (orders[index].status ?? "Rejected").toUpperCase(),
                          style: AppStyles.NormalText().copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
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
