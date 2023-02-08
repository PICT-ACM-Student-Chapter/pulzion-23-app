import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime date;
  final String imageAddress;
  final Color startColor;
  final Color endColor;

  Event(
    this.title,
    this.description,
    this.date,
    this.imageAddress,
    this.startColor,
    this.endColor,
  );
}

List<Event> techEvents = [
  Event(
    'Recode It',
    'The choice of each step backwards is usually the simplest.',
    DateTime.now(),
    'assets/images/image4.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Bug Off',
    'Where there is a code there is a bug.',
    DateTime.now(),
    'assets/images/image3.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Poster Presentation',
    'The common facts of today are the products of yesterday.',
    DateTime.now(),
    'assets/images/image2.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Just Coding',
    r'while(!succeed == try()){ keepCoding(); }',
    DateTime.now(),
    'assets/images/image1.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Recode It',
    'The choice of each step backwards is usually the simplest.',
    DateTime.now(),
    'assets/images/image4.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Bug Off',
    'Where there is a code there is a bug.',
    DateTime.now(),
    'assets/images/image3.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Poster Presentation',
    'The common facts of today are the products of yesterday.',
    DateTime.now(),
    'assets/images/image2.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Just Coding',
    r'while(!succeed == try()){ keepCoding(); }',
    DateTime.now(),
    'assets/images/image1.jpg',
    Colors.blue,
    Colors.red,
  ),
];

var nonTechEvents = [
  Event(
    'Recode It',
    'The choice of each step backwards is usually the simplest.',
    DateTime.now(),
    'assets/images/image4.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Bug Off',
    'Where there is a code there is a bug.',
    DateTime.now(),
    'assets/images/image3.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Poster Presentation',
    'The common facts of today are the products of yesterday.',
    DateTime.now(),
    'assets/images/image2.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Just Coding',
    r'while(!succeed == try()){ keepCoding(); }',
    DateTime.now(),
    'assets/images/image1.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Recode It',
    'The choice of each step backwards is usually the simplest.',
    DateTime.now(),
    'assets/images/image4.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Bug Off',
    'Where there is a code there is a bug.',
    DateTime.now(),
    'assets/images/image3.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Poster Presentation',
    'The common facts of today are the products of yesterday.',
    DateTime.now(),
    'assets/images/image2.jpg',
    Colors.blue,
    Colors.red,
  ),
  Event(
    'Just Coding',
    r'while(!succeed == try()){ keepCoding(); }',
    DateTime.now(),
    'assets/images/image1.jpg',
    Colors.blue,
    Colors.red,
  ),
];

//Images with planet images
// List<Event> techEvents = [
//   Event(
//     'Recode It',
//     'The choice of each step backwards is usually the simplest.',
//     DateTime.now(),
//     'assets/images/earth.png',
//     Colors.blue,
//     Colors.red,
//   ),
//   Event(
//     'Bug Off',
//     'Where there is a code there is a bug.',
//     DateTime.now(),
//     'assets/images/jupiter.png',
//     Colors.blue,
//     Colors.red,
//   ),
//   Event(
//     'Poster Presentation',
//     'The common facts of today are the products of yesterday.',
//     DateTime.now(),
//     'assets/images/mars.png',
//     Colors.blue,
//     Colors.red,
//   ),
//   Event(
//     'Just Coding',
//     r'while(!succeed == try()){ keepCoding(); }',
//     DateTime.now(),
//     'assets/images/mercury.png',
//     Colors.blue,
//     Colors.red,
//   ),
//   Event(
//     'Recode It',
//     'The choice of each step backwards is usually the simplest.',
//     DateTime.now(),
//     'assets/images/neptune.png',
//     Colors.blue,
//     Colors.red,
//   ),
//   Event(
//     'Bug Off',
//     'Where there is a code there is a bug.',
//     DateTime.now(),
//     'assets/images/saturn.png',
//     Colors.blue,
//     Colors.red,
//   ),
//   Event(
//     'Poster Presentation',
//     'The common facts of today are the products of yesterday.',
//     DateTime.now(),
//     'assets/images/uranus.png',
//     Colors.blue,
//     Colors.red,
//   ),
//   Event(
//     'Just Coding',
//     r'while(!succeed == try()){ keepCoding(); }',
//     DateTime.now(),
//     'assets/images/venus.png',
//     Colors.blue,
//     Colors.red,
//   ),
// ];
