import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/styles.dart';
import '../logic/login_cubit.dart';
import '../logic/sign_up_cubit.dart';
import 'login.dart';
import 'sign_up.dart';

class LoginSignUpIntro extends StatelessWidget {
  const LoginSignUpIntro({super.key});
  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;
    return Stack(
      children: [
        Panorama(
          sensitivity: 0.4,
          animSpeed: 0.5,
          sensorControl: SensorControl.Orientation,
          child: Image.asset(AppImages.spaceBackground, fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.only(
              top: padding.top + 20,
              left: padding.top / 2,
              right: padding.top / 2,
              bottom: padding.top / 2 + 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.5,
                  width: size.height * 0.5,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(150),
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
                  child: Lottie.asset(AppImages.djAstronaut),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pulzion \'23',
                      style: AppStyles.bodyTextStyle2().copyWith(fontSize: 50),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      'A 3-day event that includes a plethora of events and workshops, and is a platform for students to showcase their talents and skills.',
                      style: AppStyles.bodyTextStyle3(),
                    ),
                  ],
                ),
                Container(
                  height: size.height * 0.075,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(200),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: const Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.cardBorder,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => SignUpCubit(),
                                  child: const SignUp(),
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Register',
                              style: AppStyles.bodyTextStyle3().copyWith(
                                  fontSize: 15,
                                  color: AppColors.cardTitleTextColor),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: AppColors.cardBorder,
                        width: 2,
                        thickness: 2,
                        indent: 8.0,
                        endIndent: 8.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => LoginCubit(),
                                  child: Login(),
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: AppStyles.bodyTextStyle3().copyWith(
                                  fontSize: 15,
                                  color: AppColors.cardTitleTextColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
