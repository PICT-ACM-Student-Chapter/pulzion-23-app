import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/login_page/ui/widgets/text_field.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import 'widgets/go_back_button.dart';
import 'sign_up.dart';
import 'widgets/roundedbutton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showSpinner = false;
  late String email;
  late String password;
  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Stack(children: [
        Panorama(
          sensitivity: 0.4,
          animSpeed: 0.5,
          sensorControl: SensorControl.Orientation,
          child: Image.asset(AppImages.spaceBackground, fit: BoxFit.cover),
        ),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: GoBackButton(context),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              height: size.height - kToolbarHeight - padding.bottom - padding.top,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset(AppImages.astronautWithPlanet),
                  Text(
                    'Login',
                    style: AppStyles.bodyTextStyle2().copyWith(fontSize: 30),
                  ),
                  Text(
                    'Please sign in to continue.',
                    style: AppStyles.bodyTextStyle3().copyWith(fontSize: 15),
                  ),
                  const LoginSignUpTextField('Email', Icons.email),
                  const LoginSignUpTextField('Password', Icons.lock),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColors.loginPageAccent),
                      ),
                    ),
                  ),
                  Center(
                    child: RoundedButton(
                      btnText: 'LOGIN',
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppStyles.bodyTextStyle3().copyWith(fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const SignUp()));
                        },
                        child: Text(
                          'Sign up',
                          style: AppStyles.bodyTextStyle3()
                              .copyWith(fontSize: 15, color: AppColors.loginPageAccent),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
