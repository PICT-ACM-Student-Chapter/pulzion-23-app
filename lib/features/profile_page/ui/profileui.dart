import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowstone/glowstone.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/styles.dart';

import '../../../constants/images.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';
import '../../../constants/widgets/error_dialog.dart';
import '../../../constants/widgets/loader.dart';

import '../cubit/profile_cubit.dart';
import 'card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  //main ui starts from here
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        BlocConsumer<GlobalParameterCubit, bool>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (previous != current) {
              return true;
            }

            return false;
          },
          builder: (context, state) {
            return Image.asset(
              AppImages.spaceBackground2,
              fit: BoxFit.cover,
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: h * 0.00),
                            height: h / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(h * 0.07),
                                bottomRight: Radius.circular(h * 0.07),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                ClipPath(
                                  clipper: ClipPathClipper(),
                                  child: Container(
                                    // color: Colors.blue,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/event_frame.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    height: h * 0.23,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              40,
                                              0,
                                              20,
                                              20,
                                            ),
                                            child: SizedBox(
                                              height: h * 0.08,
                                              child: Lottie.asset(
                                                'assets/images/pmpr.json',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 25,
                                            ),
                                            child: Text(
                                              'Aditi Date',
                                              style: AppStyles.TitleText(
                                                      // fontSize: 30,
                                                      )
                                                  .copyWith(fontSize: 45),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 1),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         margin: EdgeInsets.only(left: w * 0.05),
                      //         padding: EdgeInsets.all(h * 0.01),
                      //         child: Container(
                      //             width: w * 0.23,
                      //             child: Lottie.asset(
                      //                 'assets/images/bouncepumpkin.json')),
                      //       ),
                      //       SizedBox(height: h * 0.1, width: w * 0.1),
                      //       LimitedBox(
                      //         maxWidth: w - w * 0.4,
                      //         child: FittedBox(
                      //           fit: BoxFit.scaleDown,
                      //           child: Text(
                      //             "${state.user.firstName!} ${state.user.lastName!}",
                      //             style: TextStyle(
                      //               fontSize: w * 0.08,
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.white,
                      //               fontFamily: 'QuickSand',
                      //             ),
                      //             textAlign: TextAlign.center,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: w * 0.05),
                      //         padding: EdgeInsets.all(h * 0.01),
                      //         child: Container(
                      //             width: w * 0.23,
                      //             child: Lottie.asset(
                      //                 'assets/images/bouncepumpkin.json')),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: h * 0.001),
                      SizedBox(
                        height: h * 0.04,
                      ),
                      cardDesign(
                        "USERNAME",
                        h,
                        w,
                        state.user.email!.split('@')[0],
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        // Image(image: AssetImage('assets/images/skull.png')),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      cardDesign(
                        "EMAIL",
                        h,
                        w,
                        state.user.email!,
                        const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        // Image(image: AssetImage('assets/images/potion.png')),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      cardDesign(
                        "CONTACT NO.",
                        h,
                        w,
                        state.user.mobileNumber,
                        const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        // Image(image: AssetImage('assets/images/jar.png')),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      cardDesign(
                        "YEAR",
                        h,
                        w,
                        state.user.year,
                        const Icon(
                          Icons.school,
                          color: Colors.white,
                        ),
                        // Image(image: AssetImage('assets/images/hallo.png')),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      cardDesign(
                        "COLLEGE",
                        h,
                        w,
                        state.user.college,
                        const Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                        // Image(image: AssetImage('assets/images/rip.png')),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      // SizedBox(height: 0.0000001, width: double.infinity),
                    ],
                  );
                } else if (state is ProfileError) {
                  return Column(
                    children: [
                      SizedBox(
                        height: h * 0.3,
                      ),
                      Center(
                        child: ErrorDialog(
                          state.message,
                          refreshFunction: () {
                            context.read<ProfileCubit>().getUser();
                          },
                        ),
                      ),
                    ],
                  );
                }

                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.3,
                      ),
                      const Loader(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}

class ClipPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    final path = Path();
    //(0,0) 1.Point
    path.lineTo(0, height); //2.Point
    path.quadraticBezierTo(
      width * 0.5, //3.Point --> width * 0.5, height - 100,
      height - 100,
      width, //4.Point --> width, height
      height,
    );
    path.lineTo(width, 0); //5.Point
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
