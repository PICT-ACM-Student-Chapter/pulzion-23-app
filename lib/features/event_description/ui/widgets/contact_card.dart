import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactCard extends StatelessWidget {
  final Events event;
  const ContactCard({super.key, required this.event});

  Future<void> openWhatsAppChat(String phoneNumber) async {
    final whatsappUrl = Uri.parse('whatsapp://send?phone=$phoneNumber');
    if (!await launchUrl(whatsappUrl)) {
      throw 'Could not launch WhatsApp URL';
    }
  }

  String extractPhoneNumbers(String message) {
    return message.replaceAll(RegExp(r'[^0-9]'), '');
  }

  List<String> extractedNames(String msg) {
    return msg.split('\n');
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    
    return event.id == 5
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => openWhatsAppChat(
                  extractPhoneNumbers(event.notes!).substring(0, 10),
                ),
                child: Card(
                  color: Colors.white.withOpacity(0.16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => openWhatsAppChat(
                          '9130494725',
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.green,
                        ),
                        color: Colors.white,
                      ),
                      const Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Akanksha Waghmare',
                            style: TextStyle(
                              fontFamily: 'QuickSand',
                              // fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            ' - 91304 94725',
                            style: TextStyle(
                              fontFamily: 'QuickSand',
                              // fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => openWhatsAppChat(
                  extractPhoneNumbers(event.notes!).substring(0, 10),
                ),
                child: Card(
                  color: Colors.white.withOpacity(0.16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => openWhatsAppChat(
                          extractPhoneNumbers(
                            event.notes!,
                          ).substring(0, 10),
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.green,
                        ),
                        color: Colors.white,
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            extractedNames(
                              event.notes!,
                            )[0],
                            style: const TextStyle(
                              fontFamily: 'QuickSand',
                              // fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => openWhatsAppChat(
                  extractPhoneNumbers(event.notes!).substring(10, 20),
                ),
                child: Card(
                  color: Colors.white.withOpacity(0.16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => openWhatsAppChat(
                          extractPhoneNumbers(
                            event.notes!,
                          ).substring(10, 20),
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: w * 0.08,
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            extractedNames(
                              event.notes!,
                            )[1],
                            style: const TextStyle(
                              fontFamily: 'QuickSand',
                              // fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
