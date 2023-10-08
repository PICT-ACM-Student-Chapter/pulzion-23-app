import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';

import '../../../cart_page/cubit/cart_page_cubit.dart';
import '../../../login_page/cubit/check_login_cubit.dart';
import '../../../login_page/ui/login_signup_intro.dart';
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
              ? SizedBox(
                  height: 200,
                  child: HalloweenButton(
                    buttonText: 'Register Now',
                    icon: Icons.edit_rounded,
                    onPressed: () {
                      // Navigate to LoginSignUpIntroPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginSignUpIntro(),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 200,
                  child: HalloweenButton(
                    buttonText: 'Add to Cart',
                    icon: Icons.shopping_cart,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginSignUpIntro(),
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
                    return SizedBox(
                      height: 200,
                      child: HalloweenButton(
                        buttonText: 'Register Now',
                        icon: Icons.edit_rounded,
                        onPressed: () async {
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
                      if (cartPageState.cartList.getIds().contains(event.id)) {
                        return SizedBox(
                          height: 200,
                          child: HalloweenButton(
                            buttonText: 'Remove',
                            icon: Icons.close_rounded,
                            onPressed: () {
                              if (event.id != null) {
                                BlocProvider.of<CartPageCubit>(
                                  context,
                                ).deleteItem(event.id!);
                              }
                            },
                          ),
                        );
                      } else {
                        SizedBox(
                          height: 200,
                          child: HalloweenButton(
                            buttonText: 'Add to Cart',
                            icon: Icons.shopping_cart,
                            onPressed: () {
                              if (event.id != null) {
                                BlocProvider.of<CartPageCubit>(
                                  context,
                                ).addCartItem(event.id!, null);
                              }
                            },
                          ),
                        );
                      }
                    } else if (cartPageState is CartPageLoading ||
                        cartPageState is CartItemAdded) {
                      return const Expanded(child: LoadingButton());
                    }

                    return SizedBox(
                      height: 200,
                      child: HalloweenButton(
                        buttonText: 'Add to Cart',
                        icon: Icons.shopping_cart,
                        onPressed: () {
                          if (event.id != null) {
                            BlocProvider.of<CartPageCubit>(
                              context,
                            ).addCartItem(event.id!, null);
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
