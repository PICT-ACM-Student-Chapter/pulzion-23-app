import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:bloc/bloc.dart';
import 'package:pulzion23/constants/urls.dart';
import 'package:pulzion23/features/cart_page/cubit/cart_page_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../constants/images.dart';
import '../../../../constants/models/cart_model.dart';
import '../../../../constants/styles.dart';
import 'cart_list_tile.dart';
import '../../../../constants/widgets/empty_page.dart';

class CartPageContent extends StatefulWidget {
  final CartItemList? eventList;

  CartPageContent(this.eventList, {super.key});

  @override
  State<CartPageContent> createState() => _CartPageContentState();
}

class _CartPageContentState extends State<CartPageContent> {
  String _transactionId = '';
  String _referral = 'N/A';
  List<String> referralCodes = [];

  final _formKey = GlobalKey<FormState>();

  Future<void> _getReferralCodes() async {
    referralCodes =
        await BlocProvider.of<CartPageCubit>(context).getReferralCodes();
  }

  Future<void> _launchPaymentURL() async {
    final cost = widget.eventList!.cartItems!
        .fold(0, (previousValue, element) => previousValue + element.price!);
    Uri paymentURL = Uri.parse(
      'upi://pay?pa=pictscholarship@jsb&pn=PICT&am=$cost&tn=Pulzion&cu=INR',
    );
    final bool nativeAppLaunchSucceeded = await launchUrl(
      paymentURL,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    // print(nativeAppLaunchSucceeded);
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        paymentURL,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  void _showBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (
          BuildContext ctx,
          StateSetter setSheetState,
        ) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: GlassmorphicContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
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
                height: 400,
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
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.info_outline),
                          color: Colors.white,
                          onPressed: () {
                            // showDialog(context: context, builder: (context) => showBottomSheet(context: context, builder: builder));
                          },
                        ),
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Enter Referral Code:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButton<String>(
                          style: const TextStyle(
                            fontFamily: 'QuickSand',
                            fontSize: 16,
                          ),
                          elevation: 10,
                          borderRadius: BorderRadius.circular(20),
                          value: _referral,
                          dropdownColor: Colors.black.withOpacity(0.9),
                          items: referralCodes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setSheetState(() {
                              _referral = newValue!;
                            });
                          },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                _formKey.currentState!.save();
                                try {
                                  BlocProvider.of<CartPageCubit>(context)
                                      .sendTransactionID(
                                    _transactionId,
                                    _referral,
                                  );
                                } catch (e) {
                                  print(e.toString());
                                }
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(fontSize: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.blue.withOpacity(0.5),
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: Spacer(),
                          ),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: () {
                                final cost = widget.eventList!.cartItems!.fold(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + element.price!,
                                );

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      title: const Text(
                                        'QR Code',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Panther',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      content: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.black.withOpacity(0.3),
                                              Colors.black.withOpacity(0.2),
                                              Colors.black.withOpacity(0.1),
                                            ],
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.62,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.62,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: QrImage(
                                            data:
                                                'upi://pay?pa=pictscholarship@jsb&pn=PICT&am=$cost&tn=Pulzion&cu=INR',
                                            version: QrVersions.auto,
                                            foregroundColor: Colors.white,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Close',
                                              style: TextStyle(
                                                fontFamily: 'QuickSand',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(fontSize: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.blue.withOpacity(0.5),
                              ),
                              child: const Text(
                                'Generate QR Code',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
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
                                "TOTAL : ₹${widget.eventList == null || widget.eventList!.cartItems == null ? 0 : widget.eventList!.cartItems!.fold(0, (previousValue, element) => previousValue + element.price!)} ",
                                style: AppStyles.bodyTextStyle3().copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "(${widget.eventList == null || widget.eventList!.cartItems == null ? 0 : widget.eventList!.cartItems!.length} items)",
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
                                    Color(0xff42047e),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (EndPoints.acceptingPayment ?? true) {
                                      await _getReferralCodes()
                                          .then((value) async {
                                        await _launchPaymentURL().then((value) {
                                          _showBottomSheet(context);
                                        });
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "We are currently not accepting payments...",
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
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
                child: widget.eventList == null ||
                        widget.eventList!.cartItems == null
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
                    : Stack(
                        children: [
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: Text(
                                            "Items",
                                            style: AppStyles.bodyTextStyle2()
                                                .copyWith(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        CartListTile(widget
                                            .eventList!.cartItems![index]),
                                      ],
                                    )
                                  : CartListTile(
                                      widget.eventList!.cartItems![index],
                                    );
                            },
                            itemCount: widget.eventList!.cartItems!.length,
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.02,
                            right: MediaQuery.of(context).size.width * 0.03,
                            child: FloatingActionButton(
                              onPressed: () async {
                                if (EndPoints.acceptingPayment ?? true) {
                                  await _getReferralCodes().then(
                                    (value) => _showBottomSheet(context),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "We are currently not accepting payments...",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              backgroundColor: Colors.white12,
                              child: const Icon(
                                Icons.payment,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          );
        }
      },
    );
  }
}
