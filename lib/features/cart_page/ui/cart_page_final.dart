import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/widgets/error_dialog.dart';
import 'package:pulzion23/features/cart_page/ui/cart_page_body.dart';

import '../../../constants/images.dart';
import '../cubit/cart_page_cubit.dart';

class CartPageFinal extends StatelessWidget {
  const CartPageFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartPageCubit()..loadCart(),
      child: BlocBuilder<CartPageCubit, CartPageState>(
        builder: (context, state) {
          if (state is CartPageLoading) {
            return Center(
              child: Center(child: Lottie.asset(AppImages.loadingAnimation)),
            );
          } else if (state is CartPageLoaded) {
            return CartPageContent(
              state.cartList,
            );
          } else if (state is CartPageError) {
            return const Center(
              child: ErrorDialog(
                'Error in Cart Page initialization',
              ),
            );
          }

          return Center(
            child: Center(child: Lottie.asset(AppImages.loadingAnimation)),
          );
        },
      ),
    );
  }
}
