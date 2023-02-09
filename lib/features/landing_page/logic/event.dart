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
    const Color(0xff07f49e),
    const Color(0xff42047e),
  ),
  Event(
    'Bug Off',
    'Where there is a code there is a bug.',
    DateTime.now(),
    'assets/images/image3.jpg',
    const Color(0xffe4b04d),
    const Color.fromARGB(255, 123, 71, 16),
  ),
  Event(
    'Poster Presentation',
    'The common facts of today are the products of yesterday.',
    DateTime.now(),
    'assets/images/image2.jpg',
    const Color(0xffebf4f5),
    const Color.fromARGB(255, 87, 95, 107),
  ),
  Event(
    'Just Coding',
    r'while(!succeed == try()){ keepCoding(); }',
    DateTime.now(),
    'assets/images/image1.jpg',
    const Color(0xffb15b86),
    const Color(0xff440f50),
  ),
  Event(
    'Just Coding',
    r'while(!succeed == try()){ keepCoding(); }',
    DateTime.now(),
    'assets/images/image1.jpg',
    const Color(0xffef745c),
    const Color(0xff34073d),
  ),
  Event(
    'Recode It',
    'The choice of each step backwards is usually the simplest.',
    DateTime.now(),
    'assets/images/image4.jpg',
    const Color(0xff1ed7b5),
    const Color(0xfff0f9a7),
  ),
  Event(
    'Bug Off',
    'Where there is a code there is a bug.',
    DateTime.now(),
    'assets/images/image3.jpg',
    const Color(0xff6ff7e8),
    const Color(0xff1f7ea1),
  ),
  Event(
    'Poster Presentation',
    'The common facts of today are the products of yesterday.',
    DateTime.now(),
    'assets/images/image2.jpg',
    const Color(0xffed71ad),
    const Color(0xff7277f1),
  ),
];