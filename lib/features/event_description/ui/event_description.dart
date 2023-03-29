import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/models/cart_model.dart';
import 'package:pulzion23/features/cart_page/cubit/cart_page_cubit.dart';
import 'package:pulzion23/features/event_description/ui/widgets/button.dart';
import '../../../config/size_config.dart';
import '../../../constants/models/event_model.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../login_page/cubit/check_login_cubit.dart';

class EventDescription extends StatefulWidget {
  final Events? event;

  const EventDescription({this.event, Key? key}) : super(key: key);

  @override
  State<EventDescription> createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription> with TickerProviderStateMixin {
  late final TabController tabBarController = TabController(length: 3, vsync: this);

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
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.black, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 3,
            blurRadius: 9,
            offset: const Offset(0, -4), // changes position of shadow
          ),
        ]),
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
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rs. ${event.price}",
                          style: AppStyles.bodyTextStyle3(),
                        ),
                        Text(
                          "/person",
                          style: AppStyles.bodyTextStyle3(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<CheckLoginCubit, CheckLoginState>(
                builder: (context, state) {
                  if (state is CheckLoginLoading) {
                    return Center(child: Center(child: Lottie.asset(AppImages.loadingAnimation)));
                  } else if (state is CheckLoginSuccess) {
                    return BlocConsumer<CartPageCubit, CartPageState>(
                      listener: (context, state) {
                        if (state is CartItemAdded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // BlocProvider.of<CartPageCubit>(context).loadCart();
                        } else if (state is CartItemNotAdded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          // BlocProvider.of<CartPageCubit>(context).loadCart();
                        } else if (state is CartItemDeleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          // BlocProvider.of<CartPageCubit>(context).loadCart();
                        } else if (state is CartItemNotDeleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                          // BlocProvider.of<CartPageCubit>(context).loadCart();
                        }
                      },
                      builder: (context, state) {
                        if (state is CartPageLoading) {
                          return SizedBox(
                            height: h / 12,
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        } else if (state is CartPageLoaded) {
                          var cartItems = state.cartList.cartItems == null
                              ? []
                              : List.generate(
                                  state.cartList.cartItems!.length,
                                  (index) => state.cartList.cartItems![index].id,
                                );
                          if (cartItems.contains(event.id)) {
                            return EventDescriptionPageButton(
                              'Delete from Cart',
                              Icons.delete_rounded,
                              () {
                                BlocProvider.of<CartPageCubit>(context).deleteItem(
                                  event.id!,
                                );
                              },
                            );
                          } else if (event.price == 0) {
                            return EventDescriptionPageButton(
                              'Register Now',
                              Icons.edit_rounded,
                              () {
                                log('Register');
                              },
                            );
                          } else {
                            return EventDescriptionPageButton(
                              'Add to Cart',
                              Icons.shopping_cart,
                              () {
                                BlocProvider.of<CartPageCubit>(context).addCartItem(
                                  event.id!,
                                );
                              },
                            );
                          }
                        } else if (state is CartEmpty) {
                          return event.price == 0
                              ? EventDescriptionPageButton(
                                  'Register Now',
                                  Icons.edit_rounded,
                                  () {
                                    log('Register');
                                  },
                                )
                              : EventDescriptionPageButton(
                                  'Add to Cart',
                                  Icons.shopping_cart,
                                  () {
                                    BlocProvider.of<CartPageCubit>(context).addCartItem(event.id!);
                                  },
                                );
                        }

                        return EventDescriptionPageButton(
                          'Add to Cart',
                          Icons.shopping_cart,
                          () {},
                        );
                      },
                    );
                  } else {
                    return EventDescriptionPageButton(
                      'Add to Cart',
                      Icons.shopping_cart,
                      () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.black,
                            title: const Text(
                              'Error',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            content: const Text(
                              'You need to login to add items to cart',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: h * 0.28,
                    width: double.infinity,
                    child: Image.asset(
                      AppImages.eventDescriptionBackground,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: h * 0.28,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.deepPurple.withOpacity(0.3),
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'event${event.id}',
                      child: Container(
                        width: w / 5,
                        height: w / 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: AppColors.eventCardGradientList.elementAt(
                              event.id! % AppColors.eventCardGradientList.length,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            SizeConfig.getProportionateScreenWidth(15),
                          ),
                          child: Image.network(
                            event.logo!,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w / 10),
                    SizedBox(
                      width: w * 0.6,
                      child: Text(
                        event.name!,
                        style: AppStyles.bodyTextStyle2().copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
                          tabs: const [
                            Text(
                              "Description",
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Rounds",
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Rules",
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h / 1.5,
                      width: w,
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        controller: tabBarController,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  event.tagline!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fontSizeFactor * 8,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFfafafa),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  event.description!,
                                  style: AppStyles.bodyTextStyle3(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Team Details :',
                                  style: AppStyles.bodyTextStyle3().copyWith(
                                    color: AppColors.loginPageAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  event.teams!,
                                  style: AppStyles.bodyTextStyle3(),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            event.rounds!,
                            style: AppStyles.bodyTextStyle3(),
                          ),
                          Text(
                            event.rules!,
                            style: AppStyles.bodyTextStyle3(),
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
