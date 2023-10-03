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
              backgroundColor:
                  const Color.fromARGB(255, 55, 32, 12).withOpacity(0.7),
              foregroundColor: const Color.fromARGB(255, 187, 102, 10),
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
              color: const Color.fromARGB(255, 82, 50, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
