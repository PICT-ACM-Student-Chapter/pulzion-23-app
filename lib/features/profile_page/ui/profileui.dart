import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowstone/glowstone.dart';
import 'package:panorama/panorama.dart';

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
          color: Color.fromARGB(255, 243, 152, 92),
        ),
        backgroundColor: Color.fromARGB(132, 54, 3, 50),
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
            return Panorama(
                sensitivity: 0.4,
                sensorControl:
                    state ? SensorControl.Orientation : SensorControl.None,
                child: Image.asset(
                  AppImages.halloweenBg,
                ));
            // return Panorama(
            //   sensitivity: 0.4,
            //   animSpeed: 0,
            //   sensorControl:
            //       state ? SensorControl.Orientation : SensorControl.None,
            //   child: Image.asset(
            //     AppImages.halloween_bg,
            //     fit: BoxFit.fitHeight,
            //   ),
            // );
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
                            padding: EdgeInsets.only(top: h * 0.01),
                            height: h / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(h * 0.04),
                                bottomRight: Radius.circular(h * 0.04),
                              ),
                              color: Color.fromARGB(200, 0, 39, 59),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(h * 0.02),
                                    ),
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/images/pasc_logo.png',
                                      ),
                                    ),
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 20,
                                // )
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: h * 0.01),
                                    child: Text(
                                      'WELCOME TO YOUR PROFILE',
                                      style: TextStyle(
                                        fontFamily: 'QuickSand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: h * 0.025,
                                        color:
                                            Color.fromARGB(255, 236, 122, 22),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: w * 0.05),
                              padding: EdgeInsets.all(h * 0.01),
                              child: Glowstone(
                                color: Colors.white,
                                velocity: 15,
                                radius: 5,
                                child: CircleAvatar(
                                  radius: w / 14,
                                  backgroundImage: Image.asset(
                                    "assets/images/astronaut.jpeg",
                                  ).image,
                                  //     as ImageProvider<Object>,
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.1, width: w * 0.1),
                            LimitedBox(
                              maxWidth: w - w * 0.4,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "${state.user.firstName!} ${state.user.lastName!}",
                                  style: TextStyle(
                                    fontSize: w * 0.08,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'QuickSand',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.001),
                      cardDesign(
                        "USERNAME",
                        h,
                        w,
                        state.user.email!.split('@')[0],
                        const Icon(
                          Icons.email,
                          // color: Colors.white,
                        ),
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
