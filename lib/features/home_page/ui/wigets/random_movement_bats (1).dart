// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: TranslateImage());
//   }
// }

// class TranslateImage extends StatefulWidget {
//   const TranslateImage({super.key});

//   @override
//   State<TranslateImage> createState() => _TranslateImageState();
// }

// class _TranslateImageState extends State<TranslateImage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _Translation1;
//   late Animation<Offset> _Translation2;
//   late Animation<Offset> _Translation3;
//   late Animation<Offset> _Translation4;
//   late Animation<Offset> _Translation5;
//   late Animation<Offset> _Translation6;
//   late Animation<Offset> _Translation7;
//   late Animation<Offset> _Translation8;
//   late Animation<Offset> _Translation9;
//   late Animation<Offset> _Translation10;
//   late Animation<Offset> _Translation11;
//   late Animation<Offset> _Translation12;
//   late Animation<Offset> _Translation13;
//   late Animation<Offset> _Translation14;
//   late Animation<Offset> _Translation15;
//   late Animation<Offset> _Translation16;
//   // double width = 1080, height = 1920;

//   @override
//   void initState() {
//     super.initState();

//     _animationController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 2));

//     _Translation1 = Tween(begin: Offset(4, 8), end: Offset(0, 0)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation2 = Tween(begin: Offset(8, 4), end: Offset(4, 0)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation3 = Tween(begin: Offset(6, 7), end: Offset(0, 2)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation4 = Tween(begin: Offset(6, 7), end: Offset(1, 4)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear)); //
//     _Translation5 = Tween(begin: Offset(4, 0), end: Offset(2, 1)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation6 = Tween(begin: Offset(8, 1), end: Offset(4, 1)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation7 = Tween(begin: Offset(6, 2), end: Offset(1, 0)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation8 = Tween(begin: Offset(5, 3), end: Offset(0, 1)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear)); //
//     _Translation9 = Tween(begin: Offset(2, 3), end: Offset(2, 8)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation10 = Tween(begin: Offset(2, 1), end: Offset(2, 7)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation11 = Tween(begin: Offset(4, 4), end: Offset(1, 6)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation12 = Tween(begin: Offset(1, 3), end: Offset(2, 8)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear)); //
//     _Translation13 = Tween(begin: Offset(1, 8), end: Offset(0, 0)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation14 = Tween(begin: Offset(0, 0), end: Offset(4, 4)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation15 = Tween(begin: Offset(1, 2), end: Offset(8, 8)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     _Translation16 = Tween(begin: Offset(1, 7), end: Offset(7, 7)).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.linear));
//   }

//   @override
//   void dispose() {
//     _Translation1;
//     _Translation2;
//     _Translation3;
//     _Translation4;
//     _Translation5;
//     _Translation6;
//     _Translation7;
//     _Translation8;
//     _Translation9;
//     _Translation10;
//     _Translation11;
//     _Translation12;
//     _Translation13;
//     _Translation14;
//     _Translation15;
//     _Translation16;
//     _animationController.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     _animationController.repeat();
//     return Scaffold(
//       body: Stack(
//         children: [
//           SlideTransition(
//             position: _Translation1,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation2,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation3,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation4,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation5,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation6,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation7,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation8,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation9,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation10,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation11,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation12,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation13,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation14,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation15,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//           SlideTransition(
//             position: _Translation16,
//             child: Container(
//               width: 100,
//               child: Image.asset("logo.png"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
