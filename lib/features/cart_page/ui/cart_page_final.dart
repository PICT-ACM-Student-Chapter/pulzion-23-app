import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/widgets/empty_page.dart';
import '../../../constants/widgets/error_dialog.dart';
import 'widgets/cart_page_content.dart';

import '../../../constants/images.dart';
import '../../login_page/cubit/check_login_cubit.dart';
import '../cubit/cart_page_cubit.dart';
import 'widgets/needs_login_page.dart';

class CartPageFinal extends StatelessWidget {
  const CartPageFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckLoginCubit, CheckLoginState>(
      builder: (context, loginState) {
        return loginState is CheckLoginSuccess
            ? BlocConsumer<CartPageCubit, CartPageState>(
                listener: (context, state) {
                  if (state is CartItemDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.green,
                      ),
                    );

                    BlocProvider.of<CartPageCubit>(context).loadCart();
                  } else if (state is CartItemNotDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );

                    BlocProvider.of<CartPageCubit>(context).loadCart();
                  }
                },
                builder: (context, state) {
                  if (state is CartPageLoading) {
                    return Center(
                      child: Center(
                        child: Lottie.asset(AppImages.loadingAnimation),
                      ),
                    );
                  } else if (state is CartEmpty) {
                    return Center(
                      child: EmptyPage(
                        errorMessage: 'Add some events to your Cart',
                        refreshFunction: () {
                          BlocProvider.of<CartPageCubit>(context).loadCart();
                        },
                        title: 'Your Cart is Empty',
                      ),
                    );
                  } else if (state is CartPageLoaded) {
                    return CartPageContent(state.cartList);
                  } else if (state is CartPageError) {
                    return Center(
                      child: ErrorDialog(
                        state.message,
                        refreshFunction: () =>
                            BlocProvider.of<CartPageCubit>(context).loadCart(),
                      ),
                    );
                  }

                  return Center(
                    child: Center(
                      child: Lottie.asset(
                        AppImages.loadingAnimation,
                      ),
                    ),
                  );
                },
              )
            : const NeedsLoginPage();
      },
    );
  }
}