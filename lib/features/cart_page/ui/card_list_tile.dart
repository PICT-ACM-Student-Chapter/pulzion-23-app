import 'package:flutter/material.dart';
import '../../../constants/models/event_model.dart';

class CartListTile extends StatelessWidget {
  final Events event;
  const CartListTile(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/images/image1.jpg'),
      title: Text(event.name!),
      subtitle: Text(event.mode!),
    );
  }
}
