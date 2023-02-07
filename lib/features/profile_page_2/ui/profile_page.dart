import 'package:flutter/material.dart';
import '../models/information_model.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final Info obj1 = Info(
        Name: 'Soumya Garg',
        contact_no: '7219290503',
        email: 'soumyagarg2905@gmail.com',
        userid: 'Soumya_29',
        year: "SE",
        No_of_events_reg: 3,
        eventregistered: [
          EventDetails(
              Eventname: 'Fandom',
              Slot: '1:30-2:30',
              date: DateFormat.yMMMd().format(DateTime.now())),
          EventDetails(
              Eventname: 'Insight',
              Slot: '1:30-2:30',
              date: DateFormat.yMMMd().format(DateTime.now())),
          EventDetails(
              Eventname: 'Just Coding',
              Slot: '1:30-2:30',
              date: DateFormat.yMMMd().format(DateTime.now()))
        ]);

    List<Color> myCol = [];
    for (int i = 0; i < 4; i++) {
      if (i == (Year[obj1.year])) {
        myCol.add(Colors.yellow);
      } else {
        myCol.add(Colors.grey);
      }
    }

    Widget Event(int index) {
      return Container(
        // height: 40,
        child: Card(
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 05,
          shadowColor: Colors.white,
          color: const Color.fromARGB(255, 59, 19, 130),
          child: Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    obj1.eventregistered[index].Eventname.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    obj1.eventregistered[index].Slot.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    obj1.eventregistered[index].date.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("USER PROFILE"),
          backgroundColor: const Color.fromARGB(255, 1, 24, 43),
        ),
        body: Container(
          color: const Color.fromARGB(255, 1, 24, 43),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                        child: Image.network(
                            "https://pict.acm.org/pulzion19/About-us/data1/PASClogo.png"))),
                const SizedBox(height: 15),
                const Divider(
                  color: Colors.black,
                  thickness: 5.00,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "NAME : ",
                            style: TextStyle(color: Colors.white),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(obj1.Name,
                              style: const TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "USER ID:  : ",
                            style: TextStyle(color: Colors.white),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          obj1.userid,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "EMAIL ID : ",
                            style: TextStyle(color: Colors.white),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          obj1.email,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "MOBILE NO: : ",
                            style: TextStyle(color: Colors.white),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          obj1.contact_no,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "YEAR : ",
                            style: TextStyle(color: Colors.white),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                child: Center(
                                  child: Card(
                                    color: myCol[0],
                                    child: const Center(child: Text("FE")),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: 40,
                                child: Center(
                                  child: Card(
                                    color: myCol[1],
                                    child: const Center(child: Text("SE")),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: 40,
                                child: Center(
                                  child: Card(
                                    color: myCol[2],
                                    child: const Center(child: Text("TE")),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: 40,
                                child: Center(
                                  child: Card(
                                    color: myCol[3],
                                    child: const Center(child: Text("BE")),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 5.00,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "NO OF EVENTS REGISTERED : ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          obj1.No_of_events_reg.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "LIST OF EVENTS REGISTERED: ",
                                style: TextStyle(color: Colors.white),
                                // )) , ListView(Column(children: [obj1.eventregistered],)
                              ),
                            )),
                        Container(
                          // height: 40,
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 05,
                            shadowColor: Colors.white,
                            color: const Color.fromARGB(255, 8, 3, 16),
                            child: Container(
                              height: 40,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(10),
                                children: const [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "EVENT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 35),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "SLOT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 55),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "DATE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: (ListView.builder(
                            itemBuilder: ((context, index) {
                              return Event(index);
                            }),
                            itemCount: obj1.eventregistered.length,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
