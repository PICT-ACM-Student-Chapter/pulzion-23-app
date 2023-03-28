import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/colors.dart';
import '../../../constants/models/cart_model.dart';
import '../../../constants/models/event_model.dart';
import '../../../constants/styles.dart';
import '../cubit/cart_page_cubit.dart';

class CartListTile extends StatelessWidget {
  final CartItem event;
  const CartListTile(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.025, vertical: h * 0.0075),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(50),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: const Border.fromBorderSide(
            BorderSide(
              color: AppColors.cardBorder,
              width: 0.2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.network(
                event.logo!,
                width: w * 0.15,
                height: h * 0.1,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name!,
                    style: AppStyles.bodyTextStyle3().copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "₹${event.price!}",
                    style: AppStyles.bodyTextStyle3().copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            BlocProvider(
              create: (context) => CartPageCubit(),
              child: BlocConsumer<CartPageCubit, CartPageState>(
                listener: (context, state) {
                  if (state is CartItemDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is CartItemNotDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: ((context, state) {
                  return IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
