class Event {
  final String title;
  final String description;
  final DateTime date;
  final String imageAddress;

  Event(
    this.title,
    this.description,
    this.date,
    this.imageAddress,
  );
}

var techEvents = [
  Event(
    'Recode It',
    'The choice of each step backwards is usually the simplest.',
    DateTime.now(),
    'assets/images/image4.jpg',
  ),
  Event(
    'Bug Off',
    'Where there is a code there is a bug.',
    DateTime.now(),
    'assets/images/image3.jpg',
  ),
  Event(
    'Poster Presentation',
    'The common facts of today are the products of yesterday.',
    DateTime.now(),
    'assets/images/image2.jpg',
  ),
  Event(
    'Just Coding',
    r'while(!succeed == try()){ keepCoding(); }',
    DateTime.now(),
    'assets/images/image1.jpg',
  ),
];

var nonTechEvents = [
  Event(
    'Recode It',
    'The choice of each step backwards is usually the simplest.',
    DateTime.now(),
    'assets/images/image4.jpg',
  ),
  Event(
    'Bug Off',
    'Where there is a code there is a bug.',
    DateTime.now(),
    'assets/images/image3.jpg',
  ),
  Event(
    'Poster Presentation',
    'The common facts of today are the products of yesterday.',
    DateTime.now(),
    'assets/images/image2.jpg',
  ),
  Event(
    'Just Coding',
    r'while(!succeed == try()){ keepCoding(); }',
    DateTime.now(),
    'assets/images/image1.jpg',
  ),
];
