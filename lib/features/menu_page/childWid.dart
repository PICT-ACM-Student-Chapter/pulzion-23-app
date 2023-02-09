import 'package:flutter/material.dart';

class FrostedTile extends StatelessWidget {
  IconData tileicon;
  final tilename;
  FrostedTile({required this.tilename, required this.tileicon});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: height / 70),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.5),
            foregroundColor: Colors.black,
            child: Icon(tileicon),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Container(
          child: Text(
            tilename,
            style: TextStyle(
              fontSize: height / 38,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
