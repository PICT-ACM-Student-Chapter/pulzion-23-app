// import 'package:flutter/material.dart';
// import 'booked_main.dart';

// class Ticket extends StatelessWidget {
//   const Ticket({super.key, required String title});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var height = size.height;
//     var width = size.width;

//     return Scaffold(
//       backgroundColor: Colors.purpleAccent,
//       // appBar: AppBar( title: Center(child: Text("TICKET"))),
//       body: Stack(
//         alignment: Alignment.topRight,
//         //overflow: Overflow.visible,
//         fit: StackFit.loose,
//         // fit: StackFit.expand,
//         children: <Widget>[
//            Padding(
//             padding: const EdgeInsets.fromLTRB(100, 60, 10, 0),
//             child: Expanded(
//               child: Row(
//                 children: const [
//                   Text(
//                     "YOUR EVENT IS BOOKED!!",
//                     style: TextStyle(fontSize: 25, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(30.0)),
//                 color: Colors.purpleAccent[700],
//                 image: DecorationImage(
//                   alignment: Alignment.topCenter,
//                   colorFilter: ColorFilter.mode(
//                     Colors.white.withOpacity(0.7),
//                     BlendMode.dstATop,
//                   ),
//                   image: const NetworkImage(
//                     "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHx8&w=1000&q=80",
//                   ),
//                 ),
//               ),
//               height: (3 * height) / 4.5,
//               width: (3 * width) / 5,
//             ),
//           ),
//           Positioned(
//             left: width / 2.63,
//             bottom: height / 2.4,
//             child: const Text(
//               "DATAQUEST",
//               style: TextStyle(
//                 fontSize: 22,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           Positioned(
//             left: width / 2.74,
//             bottom: height / 2.83,
//             child: const Text(
//               "DATE",
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//           Positioned(
//             left: width / 1.82,
//             bottom: height / 2.83,
//             child: const Text(
//               "TIME",
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//           Positioned(
//             left: width / 3,
//             bottom: height / 3.27,
//             child: const Text(
//               "1/2/2023",
//               style: TextStyle(fontSize: 18, color: Colors.orange),
//             ),
//           ),
//           Positioned(
//             left: width / 1.86,
//             bottom: height / 3.27,
//             child: const Text(
//               "6:00 pm",
//               style: TextStyle(fontSize: 18, color: Colors.orange),
//             ),
//           ),
//           Positioned(
//             left: width / 6,
//             bottom: height / 3.14,
//             child: ClipOval(
//               child: Container(
//                 //transform: Matrix4.identity()..rotateZ(4 * 3.1415927 / 180),
//                 height: 40,
//                 width: 50,
//                 color: Colors.purpleAccent,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: height / 3.14,
//             left: width / 1.369,
//             child: ClipOval(
//               child: Container(
//                 //transform: Matrix4.identity()..rotateZ(-4 * 3.1415927 / 180),
//                 height: 40,
//                 width: 50,
//                 color: Colors.purpleAccent,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: height / 24,
//             left: width / 2.6,
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                 color: Colors.deepPurple,
//               ),
//               height: height / 17,
//               width: width / 4,
//               child: TextButton(
//                 child: const Center(
//                   child: Text(
//                     "DONE",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const EventBookingPage(),
//                   ));
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
