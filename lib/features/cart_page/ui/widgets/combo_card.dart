import 'package:flutter/material.dart';

class Combo_List extends StatelessWidget {
  Combo_List({super.key});
  final List<Map<String, dynamic>> listOfLists = [
    {
      'events': [
        {
          'event': 'Codex',
          'type': 'Technical',
        },
        {
          'event': 'Insight',
          'type': 'Non-technical',
        },
      ],
      'actualPrice': 50.0,
      'discountPrice': 20.0,
    },
    {
      'events': [
        {
          'event': 'Fandom',
          'type': 'Non-technical',
        },
        {
          'event': 'Insight',
          'type': 'Non-technical',
        },
        {
          'event': 'HireHustle',
          'type': 'Technical',
        },
      ],
      'actualPrice': 100.0,
      'discountPrice': 70.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Expanded(
      child: ListView.builder(
        itemCount: listOfLists.length,
        itemBuilder: (BuildContext context, int index) {
          final itemList = listOfLists[index];
          final comboItems = itemList['events'] as List<Map<String, dynamic>>;
          final actualAmount = itemList['actualPrice'];
          final discountAmount = itemList['discountPrice'];

          return Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: const DecorationImage(
                    image: AssetImage("assets/images/combo1.jpeg"),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Combo ${index + 1}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 75, 29, 12),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comboItems.length,
                  itemBuilder: (BuildContext context, int innerIndex) {
                    final event = comboItems[innerIndex];
                    final eventName = event['event'];
                    final eventType = event['type'];
                    return ListTile(
                      title: Text(
                        eventName,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 105, 48, 27)),
                      ),
                      subtitle: Text(
                        eventType,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 114, 108, 108)),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '\$${actualAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '  \$${discountAmount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: w / 9,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Color.fromARGB(255, 105, 48, 27),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
