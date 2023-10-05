import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:pulzion23/constants/urls.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';
import 'package:pulzion23/features/cart_page/cubit/cart_page_cubit.dart';
import 'package:pulzion23/features/cart_page/ui/widgets/animated_prompt.dart';
import 'package:pulzion23/features/cart_page/ui/widgets/combo_card.dart';
import 'package:pulzion23/features/home_page/ui/wigets/event_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../constants/images.dart';
import '../../../../constants/models/cart_model.dart';
import '../../../../constants/styles.dart';
import 'cart_list_tile.dart';
import '../../../../constants/widgets/empty_page.dart';

class CartPageContent extends StatefulWidget {
  final CartItemList? eventList;

  const CartPageContent(this.eventList, {super.key});

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
    double w = MediaQuery.of(ctx).size.width;

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
              height: MediaQuery.of(context).size.height * 0.58,
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
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.02, top: w * 0.02),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.info_outline),
                        color: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: ctx,
                            builder: (ctx) {
                              return AlertDialog(
                                backgroundColor: Colors.black.withOpacity(0.5),
                                title: const Text(
                                  'How to pay?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text(
                                  'Steps for Payment:\n\n1.) You can either scan the QR Code or you can choose any of the given UPI app to make the payment.\n2.) After making the payment, put the Transaction ID carefully and submit it.\n3.) Make sure you do not put UPI ID in the box.\n4.) In case you mistype UPI ID instead of Transaction ID, mail us the same\n5.) Once submitted you will see the status as pending in the orders tab\n6.) We will change your status to confirmed in 48 hrs and you will be able to see your registered events in the Registered Events tab.\n7.) You won\'t be able to re-add the events to cart and perform the registration process once you make the submission.\n8.) For any issues, mail to us at: queries.pulzion@gmail.com',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.45,
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
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Enter UPI Transaction ID:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              '(PhonePe Users enter UTR number)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GlassmorphicContainer(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.07,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a transaction ID';
                                      }
                                      if (value.length != 12) {
                                        return 'Please enter 12 digit UTR ID';
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
                              'Enter Referral Code (Optional):',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GlassmorphicContainer(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.07,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'QuickSand',
                                    fontSize: 16,
                                  ),
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(20),
                                  value: _referral,
                                  dropdownColor: Colors.black.withOpacity(0.9),
                                  items: referralCodes
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? newValue) {
                                    setSheetState(() {
                                      _referral = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        _formKey.currentState!.save();
                                        try {
                                          BlocProvider.of<CartPageCubit>(
                                            context,
                                          ).sendTransactionID(
                                            _transactionId,
                                            _referral,
                                          );
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(),
                                        textStyle:
                                            const TextStyle(fontSize: 18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.5),
                                      ),
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
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
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final cost =
                                            widget.eventList!.cartItems!.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue + element.price!,
                                        );

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
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
                                                      Colors.black
                                                          .withOpacity(0.3),
                                                      Colors.black
                                                          .withOpacity(0.2),
                                                      Colors.black
                                                          .withOpacity(0.1),
                                                    ],
                                                  ),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.62,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.62,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: QrImageView(
                                                    data:
                                                        'upi://pay?pa=pictscholarship@jsb&pn=PICT&am=$cost&tn=Pulzion&cu=INR',
                                                    version: QrVersions.auto,
                                                    foregroundColor:
                                                        Colors.white,
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
                                                      Navigator.of(context)
                                                          .pop();
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
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        textStyle:
                                            const TextStyle(fontSize: 18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.5),
                                      ),
                                      child: const Text(
                                        'Generate QR Code',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
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
                ],
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
                              height: 200,
                              width: 200,
                              padding: const EdgeInsets.only(top: 17.0),
                              child: HalloweenButton(
                                icon: Icons.shopping_cart,
                                buttonText: "Checkout",
                                onPressed: () async {
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
                                // child: Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     Text(
                                //       "Checkout",
                                //       style:
                                //           AppStyles.bodyTextStyle3().copyWith(
                                //         fontSize: 18,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //     const Icon(
                                //       Icons.shopping_cart,
                                //       color: Colors.white,
                                //     ),
                                // ],
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
                          Padding(
                            padding: EdgeInsets.only(bottom: h * 0.07),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 16.0,
                                            ),
                                            child: Text(
                                              "Events",
                                              style: AppStyles.bodyTextStyle2()
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          AnimatedPrompt(
                                            id: widget.eventList!
                                                .cartItems![index].id!,
                                            title: widget.eventList!
                                                .cartItems![index].name!,
                                            subtitle: widget.eventList!
                                                .cartItems![index].price
                                                .toString(),
                                            image: Image.network(
                                              widget.eventList!
                                                  .cartItems![index].logo!,
                                              width: w * 0.15,
                                              height: h * 0.1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    : AnimatedPrompt(
                                        id: widget
                                            .eventList!.cartItems![index].id!,
                                        title: widget
                                            .eventList!.cartItems![index].name!,
                                        subtitle: widget
                                            .eventList!.cartItems![index].price
                                            .toString(),
                                        image: Image.network(
                                          widget.eventList!.cartItems![index]
                                              .logo!,
                                          width: w * 0.15,
                                          height: h * 0.1,
                                          color: Colors.white,
                                        ),
                                      );
                              },
                              itemCount:
                                  widget.eventList?.cartItems?.length ?? 0,
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.012,
                            right: MediaQuery.of(context).size.width * 0.013,
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
