import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FrostedTile extends StatelessWidget {
  final IconData tileicon;
  final String tilename;

  final String? url;
  final VoidCallback? onTap;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  const FrostedTile({
    super.key,
    required this.tilename,
    required this.tileicon,
    this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: url != null
          ? () async {
              await _launchInBrowser(Uri.parse(url!));
            }
          : onTap ??
              () {
                // If Both URL and onTap are not present then do nothing
                null;
              },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: height / 90,
            ),
            child: CircleAvatar(
              maxRadius: height * 0.025,
              backgroundColor: Colors.white.withOpacity(0.7),
              foregroundColor: Colors.black,
              child: Center(
                child: Icon(
                  tileicon,
                  size: height * 0.0255,
                ),
              ),
            ),
          ),
          SizedBox(
            width: height / 40,
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
