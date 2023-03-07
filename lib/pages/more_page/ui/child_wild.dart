import 'package:flutter/material.dart';

class FrostedTile extends StatelessWidget {
  final IconData tileicon;
  final String tilename;

  final Function? launchURL;

  const FrostedTile(
      {super.key,
      required this.tilename,
      required this.tileicon,
      this.launchURL});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: launchURL != null
          ? () async {
              await launchURL!(Uri.parse('https://pict.acm.org/pulzion19/'));
            }
          : null,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: height / 70),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.7),
              foregroundColor: Colors.black,
              child: Icon(tileicon),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            tilename,
            style: TextStyle(
              fontSize: height / 43,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
