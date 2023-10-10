import 'package:flutter/material.dart';

import '../../../../constants/styles.dart';
import '../../../combo_cubit/models/combo_model.dart';

// ignore: must_be_immutable
class OfferCard extends StatefulWidget {
  Combo combo;
  OfferCard({
    required this.combo,
    super.key,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  @override
  Widget build(BuildContext context) {
    return widget.combo.comboDetailsList == null ||
            widget.combo.comboDetailsList!.isEmpty
        ? const SizedBox()
        : Container(
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    widget.combo.comboName ?? "",
                    style: AppStyles.NormalText().copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 30),
                  ),
                  Column(
                    children: widget.combo.comboDetailsList!.map((event) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3.5,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: 30,
                                  height: 30,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Image.network(
                                      event.logo,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width / 30,
                              // ),
                              Flexible(
                                flex: 7,
                                child: Text(
                                  event.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.NormalText().copyWith(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
  }
}
