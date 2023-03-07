import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/constants/widgets/loader.dart';
import 'package:pulzion23/features/login_page/ui/widgets/go_back_button.dart';

import '../../../constants/colors.dart';
import '../cubit/check_login_cubit.dart';
import '../logic/sign_up_cubit.dart';
import 'widgets/roundedbutton.dart';
import 'widgets/text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordConfirmController =
        TextEditingController();
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController collegeController = TextEditingController();

    return Stack(
      children: [
        Panorama(
          sensitivity: 0.4,
          animSpeed: 0.5,
          sensorControl: SensorControl.Orientation,
          child: Image.asset(AppImages.spaceBackground, fit: BoxFit.cover),
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            leading: GoBackButton(context),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) async {
              if (state is SignUpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Sign Up Successful"),
                    backgroundColor: Colors.green,
                  ),
                );
                await context.read<CheckLoginCubit>().checkLogin();
                if (context.mounted) {
                  Navigator.pop(context);
                }
                return;
              }
              if (state is SignUpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              if (state is SignUpError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
            },
            builder: (context, state) {
              if (state is SignUpLoading) {
                return const Loader();
              } else {
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Account',
                          style:
                              AppStyles.bodyTextStyle2().copyWith(fontSize: 30),
                        ),
                        Text(
                          'Please fill the your information below.',
                          style: AppStyles.bodyTextStyle3(),
                        ),
                        LoginSignUpTextField(
                          'First Name',
                          Icons.mode_edit_rounded,
                          controller: firstNameController,
                        ),
                        LoginSignUpTextField(
                            'Last Name', Icons.mode_edit_rounded,
                            controller: lastNameController),
                        LoginSignUpTextField(
                          'Contact Number',
                          Icons.call,
                          controller: phoneController,
                        ),
                        LoginSignUpTextField(
                          'College Name',
                          Icons.school,
                          controller: collegeController,
                        ),
                        const YearSelectRadioTile(),
                        LoginSignUpTextField(
                          'Email',
                          Icons.email_outlined,
                          controller: emailController,
                        ),
                        LoginSignUpTextField(
                          'Password',
                          Icons.lock_outline,
                          controller: passwordController,
                        ),
                        LoginSignUpTextField(
                          'Confirm Password',
                          Icons.lock_outline,
                          controller: passwordConfirmController,
                        ),
                        Center(
                          child: RoundedButton(
                            btnText: 'SIGN UP',
                            onPressed: () async {
                              if (passwordController.text !=
                                  passwordConfirmController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Passwords do not match"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              if (firstNameController.text.isEmpty ||
                                  lastNameController.text.isEmpty ||
                                  phoneController.text.isEmpty ||
                                  collegeController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  passwordConfirmController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please fill all fields"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Password length check
                              if (passwordController.text.length < 8) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Password should be atleast 8 characters long"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Phone number length check
                              if (phoneController.text.length != 10) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Phone number should be 10 digits long"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Email validation regex
                              final RegExp emailRegex = RegExp(
                                  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                              if (!emailRegex.hasMatch(emailController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please enter a valid email"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // Phone number validation regex
                              final RegExp phoneRegex = RegExp(r'^[0-9]+$');
                              if (!phoneRegex.hasMatch(phoneController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please enter a valid phone number"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              await context.read<SignUpCubit>().signUp(
                                    college: collegeController.text.trim(),
                                    email: emailController.text.trim(),
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    password: passwordController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    year: YearSelectRadioTile.yearOfStudyString,
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class YearSelectRadioTile extends StatefulWidget {
  const YearSelectRadioTile({super.key});

  static int yearOfStudy = 1;
  static String yearOfStudyString = 'FE';

  @override
  State<YearSelectRadioTile> createState() => _YearSelectRadioTileState();
}

class _YearSelectRadioTileState extends State<YearSelectRadioTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.secondary,
                title: Text('FE', style: AppStyles.bodyTextStyle2()),
                value: 1,
                groupValue: YearSelectRadioTile.yearOfStudy,
                onChanged: (value) {
                  setState(() {
                    YearSelectRadioTile.yearOfStudy = value!;
                    YearSelectRadioTile.yearOfStudyString = 'FE';
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.secondary,
                title: Text('SE', style: AppStyles.bodyTextStyle2()),
                value: 2,
                groupValue: YearSelectRadioTile.yearOfStudy,
                onChanged: (value) {
                  setState(() {
                    YearSelectRadioTile.yearOfStudy = value!;
                    YearSelectRadioTile.yearOfStudyString = 'SE';
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.secondary,
                title: Text('TE', style: AppStyles.bodyTextStyle2()),
                value: 3,
                groupValue: YearSelectRadioTile.yearOfStudy,
                onChanged: (value) {
                  setState(() {
                    YearSelectRadioTile.yearOfStudy = value!;
                    YearSelectRadioTile.yearOfStudyString = 'TE';
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.secondary,
                title: Text('BE', style: AppStyles.bodyTextStyle2()),
                value: 4,
                groupValue: YearSelectRadioTile.yearOfStudy,
                onChanged: (value) {
                  setState(() {
                    YearSelectRadioTile.yearOfStudy = value!;
                    YearSelectRadioTile.yearOfStudyString = 'BE';
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
