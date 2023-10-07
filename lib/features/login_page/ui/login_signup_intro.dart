import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';

import '../../../config/size_config.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../logic/login_cubit.dart';
import '../logic/sign_up_cubit.dart';
import 'login.dart';
import 'sign_up.dart';

class LoginSignUpIntro extends StatelessWidget {
  const LoginSignUpIntro({super.key});

  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

  @override
  Widget build(BuildContext context) {
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
            return Image.asset(
              AppImages.spaceBackground2,
              fit: BoxFit.fill,
            );
          },
        ),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: const LoginSignupBody(),
        ),
      ],
    );
  }
}

class LoginSignupBody extends StatelessWidget {
  const LoginSignupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;

    return Container(
      margin: EdgeInsets.only(
        left: padding.top / 2,
        right: padding.top / 2,
        bottom: padding.top / 2 + 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.4,
            width: size.height * 0.5,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              // border: const Border.fromBorderSide(
              //   BorderSide(
              //     // color: AppColors.cardBorder,
              //     width: 0.2,
              //   ),
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Container(
                // height: ,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/login_page_gif.gif'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pulzion',
                style: AppStyles.NormalText().copyWith(
                  color: const Color.fromARGB(255, 208, 168, 116),
                  fontSize: SizeConfig.getProportionateScreenFontSize(35),
                ),
              ),
              Text(
                'Tech or Treat',
                style: AppStyles.TitleText().copyWith(
                  color: const Color.fromARGB(255, 208, 168, 116),
                  fontSize: SizeConfig.getProportionateScreenFontSize(35),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                'A 3-day event that includes a plethora of events and workshops, and is a platform for students to showcase their talents and skills.',
                style: AppStyles.NormalText().copyWith(
                  fontSize: SizeConfig.getProportionateScreenFontSize(15),
                  color: const Color.fromARGB(255, 208, 168, 116),
                ),
              ),
            ],
          ),
          Container(
            height: size.height * 0.075,
            width: size.width * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.4),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.orange[700]!.withOpacity(0.8),
                width: 0.7,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1.0,
                  spreadRadius: 2.0,
                  color: Colors.yellow[900]!.withOpacity(0.3),
                ),
              ],
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
                        style: AppStyles.NormalText().copyWith(
                          fontSize: 15,
                          color: AppColors.cardTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Color.fromARGB(255, 167, 74, 3),
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
                            child: const Login(),
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: AppStyles.NormalText().copyWith(
                          fontSize: 15,
                          color: AppColors.cardTitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
