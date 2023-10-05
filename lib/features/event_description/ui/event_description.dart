import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/widgets/empty_page.dart';
import 'package:pulzion23/constants/widgets/error_dialog.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';
import 'package:pulzion23/constants/widgets/loader.dart';
import 'package:pulzion23/features/combo_cubit/cubit/combo_cubit.dart';
import 'package:pulzion23/features/combo_cubit/models/combo_model.dart';
import "package:share_plus/share_plus.dart";
import '../../../constants/urls.dart';
import '../../cart_page/cubit/cart_page_cubit.dart';
import '../../../config/size_config.dart';
import '../../../constants/models/event_model.dart';
import '../ui/widgets/contact_card.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';
import 'widgets/event_mode.dart';

Widget getEventLogo(
  Events event,
  double w,
  double fontSizeFactor,
  bool isDark,
) {
  return Stack(
    children: [
      Positioned(
        left: w / 3.7,
        top: w / 7,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.5)
                    : const Color.fromARGB(255, 4, 15, 30).withOpacity(0.5),
                blurRadius: 1.0,
                spreadRadius: 7.0,
                offset: const Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Container(
            width: w / 2.6,
            height: w / 2.6,
            padding: EdgeInsets.all(
              SizeConfig.getProportionateScreenWidth(15),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: RadialGradient(
                radius: fontSizeFactor * 0.5,
                colors: [
                  const Color.fromARGB(255, 4, 15, 30).withOpacity(0.15),
                  Colors.black,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                SizeConfig.getProportionateScreenWidth(27),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withAlpha(60)
                          : Colors.orange.withAlpha(50),
                      blurRadius: 30.0,
                      spreadRadius: 10.0,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                    ),
                  ],
                ),
                child: Image.network(
                  color: Colors.white,
                  event.logo!,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: w / 1.45,
          height: w / 1.45,
          child: Image.asset(
            'assets/images/halloween_frame.png',
          ),
        ),
      ),
      // Align(
      //   alignment: Alignment.center,
      //   child: SizedBox(
      //     width: w / 1.45,
      //     height: w / 1.45,
      //     child: MaskFilter.blur(),
      //   ),
      // ),
    ],
  );
}

class EventDescription extends StatefulWidget {
  final bool isDark;
  final Events? event;
  final Function()? onChange;
  final Function()? getTheme;
  final List<Events>? eventsList;
  const EventDescription({
    this.eventsList,
    required this.isDark,
    required this.event,
    required this.onChange,
    required this.getTheme,
    Key? key,
  }) : super(key: key);

  @override
  State<EventDescription> createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription>
    with TickerProviderStateMixin {
  late final TabController tabBarController =
      TabController(length: 4, vsync: this);

  @override
  void dispose() {
    super.dispose();
    tabBarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event!;

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final fontSizeFactor = h / w;

    return Scaffold(
      backgroundColor:
          // widget.getTheme != null
          // ? widget.getTheme!().scaffoldBackgroundColor
          // :
          const Color.fromARGB(255, 13, 69, 115).withOpacity(0.2),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 9,
              offset: const Offset(0, -4), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: h / 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PRICE",
                      style: AppStyles.bodyTextStyle3().copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rs. ${event.price}",
                          style: AppStyles.bodyTextStyle3().copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //!This is the cart button
            SizedBox(
              height: h / 12,
              width: w / 2.2,
              child: HalloweenButton(
                color: widget.isDark
                    ? Color.fromARGB(255, 6, 24, 49)
                    : Color.fromARGB(255, 20, 72, 146),
                icon: Icons.shopping_cart,
                buttonText: 'Add to Cart',
                fontsize: 20,
                onPressed: () {
                  if (event.id != null) {
                    BlocProvider.of<CartPageCubit>(
                      context,
                    ).addCartItem(event.id!, null);
                  }
                },
              ),
            ),
            // DynamicButton(
            //   event: event,
            // ),
          ],
        ),
      ),
      body: BlocListener<CartPageCubit, CartPageState>(
        listenWhen: (previous, current) =>
            current is CartItemAdded ||
            current is CartItemNotAdded ||
            current is CartItemDeleted ||
            current is CartItemNotDeleted,
        listener: (context, state) {
          if (state is CartItemAdded) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            BlocProvider.of<CartPageCubit>(context).loadCart();
          } else if (state is CartItemNotAdded) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            // BlocProvider.of<CartPageCubit>(context).loadCart();
          } else if (state is CartItemDeleted) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            BlocProvider.of<CartPageCubit>(context).loadCart();
          } else if (state is CartItemNotDeleted) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            // BlocProvider.of<CartPageCubit>(context).loadCart();
          } else {
            BlocProvider.of<CartPageCubit>(context).loadCart();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top * 1.5,
                        left: MediaQuery.of(context).size.width / 20,
                      ),
                      child: InkWell(
                        onTap: (() {
                          Navigator.pop(context);
                        }),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top * 1.5,
                        right: MediaQuery.of(context).size.width / 20,
                      ),
                      child: InkWell(
                        onTap: (() {
                          Share.share(
                            '${event.description}\n\nPulzion 23 App: ${EndPoints.playStoreURL}',
                            subject: 'Pulzion 2023',
                            sharePositionOrigin:
                                const Rect.fromLTWH(0, 0, 10, 10),
                          );
                        }),
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: RadialGradient(
                      colors: [
                        const Color.fromARGB(255, 13, 69, 115).withOpacity(0.1),
                        Colors.black,
                      ],
                      radius: 0.65,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.isDark
                            ? Colors.black.withOpacity(0.5)
                            : const Color.fromARGB(255, 4, 15, 30)
                                .withOpacity(0.5),
                        // color: const Color.fromARGB(255, 13, 69, 115)
                        //     .withOpacity(0.4),
                        blurRadius: 10.0,
                        spreadRadius: 10.0,
                        offset: const Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/cobwebs.png',
                        height: h / 4.4,
                        width: w,
                        fit: BoxFit.fitWidth,
                        color: widget.getTheme!().primaryColor.withOpacity(0.3),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: h / 25,
                          ),
                          InkWell(
                            onTap: () {
                              widget.onChange!();
                            },
                            splashColor: Colors.transparent,
                            child: getEventLogo(
                              event,
                              w,
                              fontSizeFactor,
                              widget.isDark,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.isDark
                                      ? Colors.transparent
                                      : Colors.orange[700]!.withOpacity(0.25),
                                  blurRadius: 15.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              event.name!,
                              textAlign: TextAlign.center,
                              style: AppStyles.bodyTextStyle2().copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w,
                            height: h / 50,
                          ),
                          //!to add mode
                          // Align(
                          //     alignment: Alignment.centerRight,
                          //     child: EventMode(event: event)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: DefaultTabController(
                        length: 4,
                        child: TabBar(
                          labelPadding: const EdgeInsets.all(12),
                          controller: tabBarController,
                          indicator: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.orange[400]!.withOpacity(0.7),
                              ),
                            ),
                          ),
                          unselectedLabelColor: AppColors.cardSubtitleTextColor,
                          tabs: [
                            Text(
                              "Details",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Rounds",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Rules",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Offers",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w,
                      height: double.maxFinite,
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: tabBarController,
                        children: [
                          SizedBox(
                            height: 600,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    event.tagline!,
                                    textAlign: TextAlign.center,
                                    // style: TextStyle(
                                    //   fontSize: fontSizeFactor * 8,
                                    //   fontWeight: FontWeight.bold,
                                    //   color: Theme.of(context).primaryColor,
                                    //   fontStyle: FontStyle.italic,
                                    // ),
                                    style: AppStyles.bodyTextStyle3().copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    event.description!,
                                    
                                    style: AppStyles.bodyTextStyle3().copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Team Details',
                                    // style: AppStyles.bodyTextStyle3().copyWith(
                                    //   color: Theme.of(context).primaryColor,
                                    //   fontSize: 18,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                    style: AppStyles.bodyTextStyle3().copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    event.teams!,
                                    // style: AppStyles.bodyTextStyle3().copyWith(
                                    //   color: Theme.of(context).primaryColor,
                                    // ),
                                    style: AppStyles.bodyTextStyle3().copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Event Leads',
                                    // style: AppStyles.bodyTextStyle3().copyWith(
                                    //   color: Theme.of(context).primaryColor,
                                    //   fontSize: 18,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                    style: AppStyles.bodyTextStyle3().copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ContactCard(event: event),
                                ),
                              ],
                            ),
                          ),
                          // Text(
                          //   'kjdbfkjbsdfkjv',
                          //   style: AppStyles.bodyTextStyle3().copyWith(
                          //     color: Theme.of(context).primaryColor,
                          //   ),
                          // ),
                          Text(
                            event.rounds ?? '',
                            style: AppStyles.bodyTextStyle3().copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            event.rules ?? '',
                            style: AppStyles.bodyTextStyle3().copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          event.offers == null || event.offers!.isEmpty
                              ? Center(
                                  child: EmptyPage(
                                    errorMessage:
                                        "No offers available for ${event.name}",
                                    title: "",
                                  ),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: event.offers == null
                                      ? 0
                                      : event.offers == null
                                          ? 0
                                          : event.offers!.length,
                                  itemBuilder: (context, index) {
                                    final combo = event.offers![index];

                                    return InkWell(
                                      onTap: () async {
                                        // add to cart
                                        final sc =
                                            ScaffoldMessenger.of(context);
                                        final bc =
                                            BlocProvider.of<CartPageCubit>(
                                          context,
                                        );
                                        for (int eventID
                                            in combo.comboEventID!) {
                                          if (!await bc.addCartItem(
                                              eventID, null)) {
                                            sc.showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Some items in the combo are already in the cart',
                                                ),
                                              ),
                                            );
                                            for (int eventID2
                                                in combo.comboEventID!) {
                                              if (eventID2 == eventID) {
                                                break;
                                              }
                                              await bc.deleteItem(eventID2);
                                            }
                                            break;
                                          }
                                          await Future.delayed(
                                            const Duration(milliseconds: 200),
                                          );
                                        }
                                      },
                                      child: OfferCard(
                                        combo: combo,
                                        eventsList: widget.eventsList,
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OfferCard extends StatefulWidget {
  Combo combo;
  List<Events>? eventsList;
  OfferCard({
    required this.combo,
    required this.eventsList,
    super.key,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  Events? getEvent(int eventID) {
    for (var event in widget.eventsList!) {
      if (event.id == eventID) {
        return event;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    log(widget.combo.comboName!);

    return Card(
      color: Colors.deepPurple[900],
      child: Column(
        children: [
          Text(
            widget.combo.comboName ?? "",
            style: AppStyles.bodyTextStyle3().copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Column(
            children: widget.combo.comboEventID == null
                ? const [
                    EmptyPage(errorMessage: "", title: "No offers available")
                  ]
                : widget.combo.comboEventID!.map(
                    (e) {
                      final Events? event = getEvent(e);
                      if (event != null) {
                        log(event.name!);

                        return ListTile(
                          leading: Image.network(event.logo!),
                          title: Text(event.name!),
                          trailing: Text(
                            "Rs. ${widget.combo.comboTotalPrice}",
                            style: AppStyles.bodyTextStyle3().copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ).toList(),
          ),
        ],
      ),
    );
  }
}
