import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';

import '../../../config/size_config.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';
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
                style: AppStyles.bodyTextStyle2().copyWith(
                  fontSize: SizeConfig.getProportionateScreenFontSize(35),
                ),
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
                          color: AppColors.cardTitleTextColor,
                        ),
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
                            child: const Login(),
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: AppStyles.bodyTextStyle3().copyWith(
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
