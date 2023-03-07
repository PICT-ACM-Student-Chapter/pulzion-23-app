import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  final BuildContext ctx;

  const GoBackButton(this.ctx, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_rounded, color: Colors.grey[350]),
      onPressed: () {
        Navigator.of(ctx).pop(true);
      },
    );
  }
}
