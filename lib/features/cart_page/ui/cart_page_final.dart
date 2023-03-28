import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/widgets/error_dialog.dart';
import 'package:pulzion23/features/cart_page/ui/widgets/cart_page_content.dart';

import '../../../constants/images.dart';
import '../../login_page/cubit/check_login_cubit.dart';
import '../cubit/cart_page_cubit.dart';
import 'widgets/needs_login_page.dart';

class CartPageFinal extends StatelessWidget {
  const CartPageFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CartPageCubit>(context),
      child: BlocBuilder<CheckLoginCubit, CheckLoginState>(
        builder: (context, loginState) {
          return loginState is CheckLoginSuccess
              ? BlocBuilder<CartPageCubit, CartPageState>(
                  builder: (context, state) {
                    if (state is CartPageLoading) {
                      return Center(child: Center(child: Lottie.asset(AppImages.loadingAnimation)));
                    } else if (state is CartPageLoaded) {
                      return CartPageContent(state.cartList);
                    } else if (state is CartPageError) {
                      return Center(
                        child: ErrorDialog(
                          state.message,
                          refreshFunction: () => BlocProvider.of<CartPageCubit>(context).loadCart(),
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
      ),
    );
  }
}
