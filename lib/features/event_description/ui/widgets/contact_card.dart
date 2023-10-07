import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsAppChat(String phoneNumber) async {
  final whatsappUrl = Uri.parse('whatsapp://send?phone=$phoneNumber');
  if (!await launchUrl(whatsappUrl)) {
    throw 'Could not launch WhatsApp URL';
  }
}

String extractPhoneNumbers(String message) {
  return message.replaceAll(RegExp(r'[^0-9]'), '');
}

class ContactCard extends StatelessWidget {
  final Events event;
  const ContactCard({super.key, required this.event});

  List<String> extractedNames(String msg) {
    return msg.split('\n');
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    List<String> leads = event.notes!.split(',');
    List<String> names = [];
    List<String> phones = [];
    for (String lead in leads) {
      final x = lead.split('-');
      names.add(x[0].trim());
      phones.add(x[1].trim());
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: leads.length,
      itemBuilder: (context, index) => MyWidget(
        name: names[index],
        phone: '+91${phones[index]}',
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String name;
  final String phone;
  const MyWidget({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openWhatsAppChat(
        extractPhoneNumbers(phone),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.4),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.orange[700]!.withOpacity(0.8),
            width: 0.7,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 1.0,
              spreadRadius: 2.0,
              color: Colors.yellow[900]!.withOpacity(0.3),
            ),
          ],
        ),
        // color: Colors.white.withOpacity(0.16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => openWhatsAppChat(phone),
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
                  name,
                  style: AppStyles.NormalText().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
