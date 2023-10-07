import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';
import 'package:pulzion23/features/login_page/logic/login_cubit.dart';
import 'package:pulzion23/features/login_page/ui/login.dart';
import 'package:pulzion23/features/login_page/ui/widgets/roundedbutton.dart';
import 'package:pulzion23/features/login_page/ui/widgets/text_field.dart';
import '../../../../constants/images.dart';
import '../../../../project/cubit/animation_toggle_cubit.dart';
import 'package:lottie/lottie.dart';

class GetUserEmail extends StatefulWidget {
  const GetUserEmail({super.key});

  @override
  State<GetUserEmail> createState() => _GetUserEmailState();
}

class _GetUserEmailState extends State<GetUserEmail> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _otp_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _confirm_password_controller =
      TextEditingController();

  late String email;
  @override
  void dispose() {
    _otp_controller.dispose();
    _email_controller.dispose();
    _password_controller.dispose();
    _confirm_password_controller.dispose();
    super.dispose();
  }

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
            return Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is UserNotFound) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "User Not Found!",
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Something went wrong...",
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is OTPSent) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "OTP Sent Successfully!",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is PasswordChangedSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Password Changed Successfully!",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => LoginCubit(),
                    child: const Login(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UserNotFound) {
              return const Center(
                child: Text('User not found'),
              );
            } else if (state is LoginFailure || state is LoginFailure) {
              return const Center(
                child: Text('Something went wrong...'),
              );
            } else if (state is OTPSent) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text(
                          'Enter new Password',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Panther',
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Form(
                          child: Column(
                            children: [
                              LoginSignUpTextField(
                                'Enter your OTP',
                                Icons.message,
                                controller: _otp_controller,
                                obscureText: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              LoginSignUpTextField(
                                'Enter new password',
                                Icons.password,
                                controller: _password_controller,
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              LoginSignUpTextField(
                                'Confirm Password',
                                Icons.lock,
                                controller: _confirm_password_controller,
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                          btnText: 'Reset',
                          onPressed: () async {
                            if (_password_controller.text !=
                                _confirm_password_controller.text) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Passwords do not match!",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );

                              return;
                            }
                            await BlocProvider.of<LoginCubit>(context)
                                .resetPassword(
                              _otp_controller.text,
                              _password_controller.text,
                              email,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is LoginInitial) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Reset Password',
                          style: AppStyles.NormalText().copyWith(
                            fontSize: 30,
                            color: const Color.fromARGB(255, 208, 168, 116),
                            // fontWeight: FontWeight.bold,
                            fontFamily: 'Gothica-Book',
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        LoginSignUpTextField(
                          'Enter your email',
                          Icons.email,
                          controller: _email_controller,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // RoundedButton(
                        //   btnText: 'Send OTP',
                        //   onPressed: () async {
                        //     email = _email_controller.text;
                        //     await BlocProvider.of<LoginCubit>(context)
                        //         .sendOTP(_email_controller.text);
                        //   },
                        // ),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: HalloweenButton(
                            icon: Icons.email,
                            buttonText: 'Send OTP',
                            onPressed: () async {
                              email = _email_controller.text;
                              await BlocProvider.of<LoginCubit>(context)
                                  .sendOTP(_email_controller.text);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Lottie.asset(AppImages.loadingAnimation),
              );
            }
          },
        ),
      ],
    );
  }
}
