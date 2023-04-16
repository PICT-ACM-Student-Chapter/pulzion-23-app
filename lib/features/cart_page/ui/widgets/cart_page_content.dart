import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:bloc/bloc.dart';
import 'package:pulzion23/features/cart_page/cubit/cart_page_cubit.dart';

import '../../../../constants/images.dart';
import '../../../../constants/models/cart_model.dart';
import '../../../../constants/styles.dart';
import 'cart_list_tile.dart';
import '../../../../constants/widgets/empty_page.dart';

class CartPageContent extends StatelessWidget {
  final CartItemList? eventList;
  String _transactionId = '';
  final _formKey = GlobalKey<FormState>();
  CartPageContent(this.eventList, {super.key});

  void _showBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: GlassmorphicContainer(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.47,
            borderRadius: 10,
            blur: 10,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.2),
              ],
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Enter Transaction ID:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GlassmorphicContainer(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 56,
                      borderRadius: 16,
                      blur: 10,
                      alignment: Alignment.center,
                      border: 1,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.2),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a transaction ID';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _transactionId = newValue!;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Transaction ID',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.credit_card,
                                color: Colors.grey,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Please follow the instructions to complete the transaction.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();

                        // redirect to Gpay...

                        try {
                          BlocProvider.of<CartPageCubit>(context)
                              .sendTransactionID(
                            _transactionId,
                          );
                        } catch (e) {
                          print(e.toString());
                        }
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.blue[900],
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return BlocConsumer<CartPageCubit, CartPageState>(
      listener: (context, state) {
        if (state is TransactionError) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is SentTransaction) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SendingTransaction) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SentTransaction) {
          return Center(
            child: EmptyPage(
              errorMessage: 'Add some events to your Cart',
              refreshFunction: () {},
              title: 'Your Cart is Empty',
            ),
          );
        } else {
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
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff07f49e),
                                    Color(0xff42047e)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: InkWell(
                                  onTap: () {
                                    _showBottomSheet(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Checkout",
                                        style:
                                            AppStyles.bodyTextStyle3().copyWith(
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
                            ),
                            // BlocBuilder<CartPageCubit, CartPageState>(
                            //   builder: (ctx, state) {
                            //     if (state is SendingTransaction) {
                            //       return IconButton(
                            //         icon: const Icon(Icons.refresh),
                            //         onPressed: () {
                            //           _showBottomSheet(context);
                            //         },
                            //       );
                            //     }

                            //     return Container();
                            //   },
                            // ),
                          ],
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
                                        style:
                                            AppStyles.bodyTextStyle2().copyWith(
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
      },
    );
  }
}
