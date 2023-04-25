// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:panorama/panorama.dart';
// import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';
// import '../../../constants/models/event_model.dart';
// import '../../../constants/images.dart';

// class BookedWindow extends StatefulWidget {
//   // Events event;
//   BookedWindow({super.key});

//   @override
//   State<BookedWindow> createState() => _BookedWindowState();
// }

// class _BookedWindowState extends State<BookedWindow>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   List<Color> notselected = [
//     Colors.white.withOpacity(0.2),
//     Colors.black.withOpacity(0.3),
//   ];
//   List<Color> selected = [
//     Colors.white.withOpacity(0.3),
//     Colors.white.withOpacity(0.6),
//   ];
//   List<bool> c = [false, false, false, false];

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget eventSlot(
//     int i,
//     double h,
//     double w,
//   ) {
//     return GestureDetector(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 4.0, right: 4.0),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(
//               (h * 0.09),
//             ),
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: c[i] ? selected : notselected,
//             ),
//           ),
//           height: h * 0.09,
//           width: w * 0.2,
//           child: Center(
//             child: Text(
//               "Slot ${i + 1}",
//               style: TextStyle(
//                 color: c[i] ? Colors.black : Colors.white,
//                 fontWeight: c[i] ? FontWeight.bold : FontWeight.w100,
//               ),
//             ),
//           ),
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           for (int k = 0; k < 4; k++) {
//             if (k == i) {
//               c[i] = true;
//             } else {
//               c[k] = false;
//             }
//           }
//         });
//       },
//     );
//   }

//   Widget eventDate(double h, double w, String eventDate, String eventDay) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: h * 0.15,
//         width: w * 0.2,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               // Color.fromARGB(255, 35, 21, 57),
//               Colors.black.withOpacity(0.4),
//               Colors.white.withOpacity(0.3),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(h * 0.095),
//           border: Border.all(
//             color: Colors.white,
//             width: h * 0.001,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: h * 0.03,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(h * 0.005),
//                 child: Text(
//                   eventDay,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                     fontSize: h * 0.028,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(h * 0.002),
//                 child: Text(
//                   eventDate,
//                   style: TextStyle(fontSize: h * 0.025),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   //main ui starts from here
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           BlocConsumer<GlobalParameterCubit, bool>(
//             listener: (context, state) {},
//             buildWhen: (previous, current) {
//               if (previous != current) {
//                 return true;
//               }

//               return false;
//             },
//             builder: (context, state) {
//               return Panorama(
//                 sensitivity: 0.4,
//                 animSpeed: 0.5,
//                 sensorControl:
//                     state ? SensorControl.Orientation : SensorControl.None,
//                 child: Image.asset(
//                   AppImages.spaceBackground,
//                   fit: BoxFit.cover,
//                 ),
//               );
//             },
//           ),
//           Column(
//             children: [
//               const SizedBox(
//                 height: 30,
//                 width: double.infinity,
//                 child: Center(
//                   child: Text(
//                     "BOOK SLOTS",
//                     style: TextStyle(color: Colors.white, fontSize: 30),
//                   ),
//                 ),
//               ),
//               SizedBox(height: h * 0.03),
//               Container(
//                 height: h * 0.2,
//                 width: h * 0.3,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Colors.white.withOpacity(.2),
//                       const Color.fromARGB(255, 9, 45, 74).withOpacity(.1),
//                       Colors.white.withOpacity(.2),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(h * 0.045),
//                   border: Border.all(
//                     color: Colors.white,
//                     width: h * 0.001,
//                   ),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     "Event logo",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(height: h * 0.02),
//               AnimatedContainer(
//                 curve: Curves.easeIn,
//                 duration: const Duration(seconds: 5),
//                 height: h * 0.1,
//                 width: w * 0.4,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Colors.white.withOpacity(.2),
//                       const Color.fromARGB(255, 9, 45, 74).withOpacity(.1),
//                       Colors.white.withOpacity(.2),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(h * 0.035),
//                   border: Border.all(
//                     color: Colors.white,
//                     width: h * 0.001,
//                   ),
//                 ),
//                 child: const Center(
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: Text(
//                       "EVENT NAME ",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: h * 0.02,
//               ),
//               Container(
//                 height: h * 0.055,
//                 width: w - w * 0.05,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Colors.white.withOpacity(.2),
//                       const Color.fromARGB(255, 9, 45, 74).withOpacity(.1),
//                       Colors.white.withOpacity(.2),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(h * 0.035),
//                   border: Border.all(
//                     color: Colors.white,
//                     width: h * 0.001,
//                   ),
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(h * 0.01),
//                     child: const Text(
//                       "Welcome to this event of pulzion 2023.",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: h * 0.03),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10.0),
//                   child: Text(
//                     "Event Date: ",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       fontSize: h * 0.025,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   eventDate(h, w, "12", "WED"),
//                   eventDate(h, w, "13", "THU"),
//                   eventDate(h, w, "14", "FRI"),
//                 ],
//               ),
//               SizedBox(height: h * 0.01),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Select Slot: ",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: h * 0.025,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   eventSlot(0, h, w),
//                   eventSlot(1, h, w),
//                   eventSlot(2, h, w),
//                   eventSlot(3, h, w),
//                 ],
//               ),
//               SizedBox(height: h * 0.02),
//               GestureDetector(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text('SLOT BOOKED'),
//                         content: const Text('Your slot has been booked!'),
//                         actions: [
//                           TextButton(
//                             child: const Text('Close'),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Container(
//                   width: w - w * 0.5,
//                   decoration: BoxDecoration(
//                     color: Colors.blueAccent,
//                     borderRadius: BorderRadius.circular(12),
//                     gradient: const LinearGradient(
//                       colors: [Color(0xff07f49e), Color(0xff42047e)],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "CONFIRM SLOT  ",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Icon(
//                           Icons.shopping_cart,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/home_page/ui/wigets/custom_appbar.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';

class BookSlots extends StatelessWidget {
  const BookSlots({super.key});

  Widget gradientContainer(Widget child, double h, double w) {
    return Container(
      height: h,
      width: w,
      margin: EdgeInsets.symmetric(
        horizontal: h * 0.025,
        vertical: w * 0.0075,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.025,
        vertical: h * 0.015,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.eventCardGradientList.elementAt(
            0 %
                // orders[index].id! %
                AppColors.eventCardGradientList.length,
          ),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: const Border.fromBorderSide(
          BorderSide(
            color: AppColors.cardBorder,
            width: 0.2,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
    );
  }

  Widget slotContainer() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'Date: 3/5/23',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
              Text(
                'Location: A1 - 208',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.white,
            thickness: 0.3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Time: 3 PM - 4 PM',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'QuickSand',
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xff07f49e), Color(0xff42047e)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Book Slot',
                        style: AppStyles.bodyTextStyle3().copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        BlocConsumer<GlobalParameterCubit, bool>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (previous != current) {
              return true;
            }

            return false;
          },
          builder: (context, state) {
            return Panorama(
              sensitivity: 0.4,
              animSpeed: 0.5,
              sensorControl:
                  state ? SensorControl.Orientation : SensorControl.None,
              child: Image.asset(
                AppImages.spaceBackground,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.08,
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          "BOOK SLOTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Panther',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Container(
                      height: h * 0.2,
                      width: w,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.white10,
                            Colors.white30,
                          ],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyvb4YY3-iRh4TBxiOCAdbLrW4_Mn50iqYz4jIfAzASwGrij5japZr8xeqepFlK8ScEiE&usqp=CAU',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: h * 0.1,
                      width: w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.white10,
                            Colors.white30,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: w * 0.09,
                          ),
                          CircleAvatar(
                            radius: w * 0.07,
                            backgroundImage: const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyvb4YY3-iRh4TBxiOCAdbLrW4_Mn50iqYz4jIfAzASwGrij5japZr8xeqepFlK8ScEiE&usqp=CAU',
                            ),
                          ),
                          SizedBox(
                            width: w * 0.14,
                          ),
                          const Text(
                            'Dextrous',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Panther',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    SizedBox(
                      height: h * 0.8,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.white10,
                                  Colors.white30,
                                ],
                              ),
                            ),
                            height: h * 0.2,
                            width: w,
                            child: slotContainer(),
                          ),
                        ),
                        itemCount: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
