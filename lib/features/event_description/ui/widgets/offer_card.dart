import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:pulzion23/features/cart_page/cubit/cart_page_cubit.dart';
import 'package:pulzion23/features/event_description/ui/widgets/lightOnOff.dart';

import '../../../../constants/styles.dart';
import '../../../combo_cubit/models/combo_model.dart';

// ignore: must_be_immutable
class OfferCard extends StatefulWidget {
  Combo combo;
  final List<Events> eventList;
  OfferCard({
    required this.combo,
    required this.eventList,
    super.key,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  final cacheManager = CacheManager(Config(
    'my_custom_cache_key',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));

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
                    children: [
                      Column(
                        children: widget.combo.comboDetailsList!.map((event) {
                          return InkWell(
                            onTap: () {
                              Events? foundEvent;
                              for (var element in widget.eventList) {
                                if (element.name == event.name) {
                                  foundEvent = element;
                                }
                              }
                              if (foundEvent != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DarkSample(
                                      event: foundEvent!,
                                    ),
                                    settings: RouteSettings(
                                      arguments: widget.eventList,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Padding(
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        width: 30,
                                        height: 30,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: CachedNetworkImage(
                                            imageUrl: event.logo,
                                            color: Colors.white,
                                            placeholder: (context, url) =>
                                                Container(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(),
                                            cacheManager: cacheManager,
                                            fadeInDuration: const Duration(
                                              milliseconds: 100,
                                            ),
                                            fit: BoxFit.fitWidth,
                                            key: UniqueKey(),
                                          ),
                                          // child: Image.network(
                                          //   event.logo,
                                          //   color: Colors.white,
                                          // ),
                                        ),
                                      ),
                                    ),
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
                            ),
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              final sc = ScaffoldMessenger.of(context);
                              final bc = BlocProvider.of<CartPageCubit>(
                                context,
                              );
                              BlocProvider.of<CartPageCubit>(context)
                                  .addCombo(widget.combo.comboID!);
                            },
                            child: Text(
                              'Add to Cart',
                              style: AppStyles.NormalText().copyWith(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                Text(
                                  '₹${widget.combo.comboTotalPrice.toString()}',
                                  style: AppStyles.NormalText().copyWith(
                                    fontSize: 17,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  '₹${widget.combo.comboDiscountedPrice.toString()}',
                                  style: AppStyles.NormalText().copyWith(
                                    fontSize: 25,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
