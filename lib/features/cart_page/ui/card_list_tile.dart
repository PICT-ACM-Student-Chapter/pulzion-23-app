import 'package:flutter/material.dart';
import '../../../constants/models/event_model.dart';
//import 'package:pulzion23/features/cart_page/ui/cart_page.dart';

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

var eventList = <Events>[
  Events(name: 'Electroquest', mode: 'Technical Events', price: 50.0),
  Events(name: 'Fandom Quiz', mode: 'Non-Technical Events', price: 30.0),
];
