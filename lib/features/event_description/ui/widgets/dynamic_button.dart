import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/models/event_model.dart';

import '../../../cart_page/cubit/cart_page_cubit.dart';
import '../../../login_page/cubit/check_login_cubit.dart';
import '../../../login_page/ui/login_signup_intro.dart';
import 'button.dart';
import 'loading_button.dart';

class DynamicButton extends StatelessWidget {
  final Events event;
  const DynamicButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckLoginCubit, CheckLoginState>(
              builder: (context, state) {
                if (state is CheckLoginFailure || state is CheckLoginLoading) {
                  return event.price == 0
                      ? Expanded(
                          child: EventDescriptionPageButton(
                            'Register Now',
                            Icons.edit_rounded,
                            () {
                              // Navigate to LoginSignUpIntroPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginSignUpIntro(),
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: EventDescriptionPageButton(
                            'Add to Cart',
                            Icons.shopping_cart,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginSignUpIntro(),
                                ),
                              );
                            },
                          ),
                        );
                }

                return Container(
                  child: event.price == 0
                      ? BlocBuilder<CartPageCubit, CartPageState>(
                          builder: (context, state) {
                            return Expanded(
                              child: EventDescriptionPageButton(
                                'Register Now',
                                Icons.edit_rounded,
                                () async {
                                  BlocProvider.of<CartPageCubit>(context)
                                      .registerFreeEvent(event.id!, context);
                                },
                              ),
                            );
                          },
                        )
                      : BlocConsumer<CartPageCubit, CartPageState>(
                          listener: (context, state) {},
                          builder: ((context, cartPageState) {
                            if (cartPageState is CartPageLoaded) {
                              if (cartPageState.cartList
                                  .getIds()
                                  .contains(event.id)) {
                                return Expanded(
                                  child: EventDescriptionPageButton(
                                    'Remove',
                                    Icons.close_rounded,
                                    () {
                                      if (event.id != null) {
                                        BlocProvider.of<CartPageCubit>(
                                          context,
                                        ).deleteItem(event.id!);
                                      }
                                    },
                                  ),
                                );
                              } else {
                                Expanded(
                                  child: EventDescriptionPageButton(
                                    'Add to Cart',
                                    Icons.shopping_cart,
                                    () {
                                      if (event.id != null) {
                                        BlocProvider.of<CartPageCubit>(
                                          context,
                                        ).addCartItem(event.id!);
                                      }
                                    },
                                  ),
                                );
                              }
                            } else if (cartPageState is CartPageLoading ||
                                cartPageState is CartItemAdded) {
                              return const Expanded(child: LoadingButton());
                            }

                            return Expanded(
                              child: EventDescriptionPageButton(
                                'Add to Cart',
                                Icons.shopping_cart,
                                () {
                                  if (event.id != null) {
                                    BlocProvider.of<CartPageCubit>(
                                      context,
                                    ).addCartItem(event.id!);
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                );
              },
            );
  }
}