import 'events.dart';

List<Event> Events = [
  Event(
    title: "Just Coding",
    imgUrl: "https://pict.acm.org/pulzion-18/res/img/JC.jpg",
    tagline: "while(!All-Clear()) try();",
    explaination:
        "Are you someone whose fingers look around for a keyboard when you come across a problem statement? Then Just Coding is meant for you, a stimulating yet fun coding event!\n\nJust Coding is a competition where the participants will have to write correct and efficient codes for the given set of problem statements.",
    rules: <int, String>{
      1: "Both the groups, FE-SE and TE-BE, will be given maximum 2 hours to complete.",
      2: "Any offline IDE can be used but use of internet and any online IDE other than HackerRank is prohibited.",
      3: "Permitted languages will be C, C++, Python and Java.",
    },
    distribution: <String, String>{
      "FE-SE (Junior Team)": "Teams of 2",
      "TE-BE (Senior Team)": "Teams of 2",
    },
    fees: 100,
    isTech: true,
    contacts: <String, String>{
      "ABC": "1234567891",
      "XYZ": "8234239462",
    },
    roundDetails: <String, String>{
      "Round 1":
          "This is a coding round where teams have to code for given problems in a limited time",
      "Round 2":
          "Qualifying teams will then have to code for the problems of higher difficulty level in a limited time",
    },
  ),
];
