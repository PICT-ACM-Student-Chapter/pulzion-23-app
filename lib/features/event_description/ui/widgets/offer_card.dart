import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../constants/models/event_model.dart';
import '../../../../constants/styles.dart';
import '../../../../constants/widgets/empty_page.dart';
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
    if (widget.combo.comboDetailsList == null ||
        widget.combo.comboDetailsList!.isEmpty) {
      return Container();
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 133, 134, 141).withOpacity(0.5),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text(
                widget.combo.comboName ?? "",
                style: AppStyles.bodyTextStyle3().copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 30),
              ),
            ),
            Column(
              children: widget.combo.comboDetailsList!.map(
                (event) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.network(
                                  event.logo,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                          Text(
                            event.name,
                            style: TextStyle(color: Colors.white),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      );
    }
  }
}
