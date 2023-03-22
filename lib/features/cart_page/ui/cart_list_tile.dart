import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/models/event_model.dart';
import '../../../constants/styles.dart';

class CartListTile extends StatelessWidget {
  final Events event;
  const CartListTile(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.025),
      child: ListTile(
        leading: Image.network(
          event.logo!,
          width: w * 0.15,
        ),
        title: Text(
          event.name!,
          style: AppStyles.bodyTextStyle3().copyWith(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          "₹" + event.price!.toString(),
          style: AppStyles.bodyTextStyle3().copyWith(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
