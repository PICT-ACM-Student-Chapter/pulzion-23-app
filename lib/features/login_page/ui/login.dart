import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../constants/widgets/loader.dart';
import '../cubit/check_login_cubit.dart';
import '../logic/login_cubit.dart';
import 'widgets/go_back_button.dart';
import 'widgets/roundedbutton.dart';
import 'widgets/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
          appBar: AppBar(
            elevation: 0,
            leading: GoBackButton(context),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login Successful"),
                    backgroundColor: Colors.green,
                  ),
                );
                await context.read<CheckLoginCubit>().checkLogin();
                if (context.mounted) {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              }
              if (state is LoginFailure) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
              if (state is LoginError) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              if (state is LoginInitial ||
                  state is LoginFailure ||
                  state is LoginError) {
                return SingleChildScrollView(
                  child: Container(
                    height: size.height -
                        kToolbarHeight -
                        padding.bottom -
                        padding.top,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Lottie.asset(AppImages.astronautWithPlanet),
                        Text(
                          'Login',
                          style:
                              AppStyles.bodyTextStyle2().copyWith(fontSize: 30),
                        ),
                        Text(
                          'Please sign in to continue.',
                          style:
                              AppStyles.bodyTextStyle3().copyWith(fontSize: 15),
                        ),
                        LoginSignUpTextField(
                          'Email',
                          Icons.email,
                          controller: emailController,
                        ),
                        LoginSignUpTextField(
                          'Password',
                          Icons.lock,
                          controller: passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              null;
                            },
                            child: const Text(
                              'Forgot Password?',
                              style:
                                  TextStyle(color: AppColors.loginPageAccent),
                            ),
                          ),
                        ),
                        Center(
                          child: RoundedButton(
                            btnText: 'LOGIN',
                            onPressed: () async {
                              context.read<LoginCubit>().login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        )
                        // TODO: Figure out bloc logic then add this!
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "Don't have an account?",
                        //       style: AppStyles.bodyTextStyle3()
                        //           .copyWith(fontSize: 15),
                        //     ),
                        //     TextButton(
                        //       onPressed: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => const SignUp()));
                        //       },
                        //       child: Text(
                        //         'Sign up',
                        //         style: AppStyles.bodyTextStyle3().copyWith(
                        //             fontSize: 15,
                        //             color: AppColors.loginPageAccent),
                        //       ),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                );
              }
              if (state is LoginLoading) {
                return const Loader();
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
