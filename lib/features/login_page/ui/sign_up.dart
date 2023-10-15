import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';

import '../../../project/cubit/animation_toggle_cubit.dart';
import '../../../constants/styles.dart';
import '../../../constants/widgets/loader.dart';
import 'widgets/go_back_button.dart';

import '../cubit/check_login_cubit.dart';
import '../logic/sign_up_cubit.dart';
import 'widgets/text_field.dart';
import 'package:csc_picker/csc_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController othercollegeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    collegeController.dispose();
  }

  bool isOpen = true;
  String selectOption = 'Select College';
  // late String? valueChoose;
  List<String> colleges = ["PICT", "Other"];
  String countryValue = "";
  String address = "Country";
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
                  SnackBar(
                    content: Text(
                      "Sign Up Successful",
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 196, 117, 15),
                  ),
                );
                await context.read<CheckLoginCubit>().checkLogin();
                if (mounted) {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }

                return;
              }
              if (state is SignUpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 78, 48, 21),
                  ),
                );

                return;
              }
              if (state is SignUpError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(255, 78, 48, 21),
                  ),
                );

                return;
              }
            },
            builder: (context, state) {
              return state is SignUpLoading
                  ? const Center(child: Loader())
                  : Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create Account',
                              style: AppStyles.NormalText().copyWith(
                                fontSize: 30,
                                color: const Color.fromARGB(255, 228, 188, 136),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Please fill the your information below.',
                                style: AppStyles.NormalText().copyWith(
                                  color:
                                      const Color.fromARGB(255, 208, 168, 116),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            LoginSignUpTextField(
                              'First Name',
                              Icons.mode_edit_rounded,
                              controller: firstNameController,
                              obscureText: false,
                            ),
                            LoginSignUpTextField(
                              'Last Name',
                              Icons.mode_edit_rounded,
                              controller: lastNameController,
                              obscureText: false,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.only(top: 8),
                                child: CSCPicker(
                                  defaultCountry: CscCountry.India,
                                  selectedItemStyle:
                                      AppStyles.NormalText().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                                  onCountryChanged: (country) {
                                    setState(() {
                                      log(country.toString());
                                      countryValue = country;
                                      address = countryValue;
                                    });
                                  },
                                  countryDropdownLabel: address,
                                  dropdownItemStyle:
                                      AppStyles.NormalText().copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                                  dropdownDialogRadius: 10.0,
                                  countrySearchPlaceholder: address,
                                  dropdownHeadingStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                  ),
                                  showCities: false,
                                  showStates: false,
                                  dropdownDecoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.black.withOpacity(0.4),
                                        Colors.black.withOpacity(0.4),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color:
                                          Colors.orange[700]!.withOpacity(0.8),
                                      width: 0.7,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1.0,
                                        spreadRadius: 2.0,
                                        color: Colors.yellow[900]!
                                            .withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            LoginSignUpTextField(
                              'Contact Number',
                              Icons.call,
                              controller: phoneController,
                              obscureText: false,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  Container(
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
                                        color: Colors.orange[700]!
                                            .withOpacity(0.8),
                                        width: 0.7,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1.0,
                                          spreadRadius: 2.0,
                                          color: Colors.yellow[900]!
                                              .withOpacity(0.3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Theme(
                                            data: ThemeData(
                                              unselectedWidgetColor:
                                                  Colors.white,
                                            ),
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.zero,
                                              activeColor: const Color.fromARGB(
                                                  255, 228, 188, 136),
                                              title: Text(
                                                'PICT',
                                                style: AppStyles.NormalText()
                                                    .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: 1,
                                              groupValue: YearSelectRadioTile
                                                  .yearOfStudy,
                                              onChanged: (value) {
                                                setState(() {
                                                  YearSelectRadioTile
                                                      .yearOfStudy = value!;
                                                  YearSelectRadioTile
                                                          .yearOfStudyString =
                                                      'PICT';
                                                  isOpen = true;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Theme(
                                            data: ThemeData(
                                              unselectedWidgetColor:
                                                  Colors.white,
                                            ),
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.zero,
                                              activeColor: const Color.fromARGB(
                                                  255, 228, 188, 136),
                                              title: Text(
                                                'Other',
                                                style: AppStyles.NormalText()
                                                    .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: 2,
                                              groupValue: YearSelectRadioTile
                                                  .yearOfStudy,
                                              onChanged: (value) {
                                                setState(() {
                                                  YearSelectRadioTile
                                                      .yearOfStudy = value!;
                                                  YearSelectRadioTile
                                                          .yearOfStudyString =
                                                      'Other';
                                                  isOpen = false;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () => {
                                  //     setState(() {
                                  //       isOpen = !isOpen;
                                  //     }),
                                  //   },
                                  // child: Padding(
                                  //   padding: const EdgeInsets.only(top: 8.0),
                                  //   child: Container(
                                  //     height:
                                  //         MediaQuery.of(context).size.height *
                                  //             0.07,
                                  //     decoration: BoxDecoration(
                                  //       gradient: LinearGradient(
                                  //         colors: [
                                  //           Colors.black.withOpacity(0.6),
                                  //           Colors.black.withOpacity(0.4),
                                  //           Colors.black.withOpacity(0.4),
                                  //         ],
                                  //         begin: Alignment.centerLeft,
                                  //         end: Alignment.centerRight,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(24),
                                  //       border: Border.all(
                                  //         color: Colors.orange[700]!
                                  //             .withOpacity(0.8),
                                  //         width: 0.7,
                                  //       ),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           blurRadius: 1.0,
                                  //           spreadRadius: 2.0,
                                  //           color: Colors.yellow[900]!
                                  //               .withOpacity(0.3),
                                  //         ),
                                  //       ],
                                  //       // image: DecorationImage(
                                  //       //   colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6),BlendMode.dstATop),
                                  //       //     image: AssetImage('assets/images/fields.jpg'),
                                  //       //     fit: BoxFit.fill),

                                  //       // borderRadius: const BorderRadius.all(
                                  //       //   Radius.circular(25.0),
                                  //       // ),
                                  //       // color: AppColors.primary.withAlpha(100),
                                  //       // border: Border.all(
                                  //       //   color: Colors.black26,
                                  //       //   width: 2.0,
                                  //       // ),
                                  //     ),
                                  //     child: Row(
                                  //       // mainAxisAlignment:
                                  //       //     MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         const SizedBox(
                                  //           width: 8,
                                  //         ),
                                  //         const Icon(
                                  //           Icons.school_outlined,
                                  //           color: Colors
                                  //               .white, // add custom icons also
                                  //         ),
                                  //         const SizedBox(
                                  //           width: 15,
                                  //         ),
                                  //         Text(
                                  //           selectOption,
                                  //           style: (const TextStyle(
                                  //             color: Colors.white,
                                  //             fontWeight: FontWeight.w400,
                                  //             fontSize: 16,
                                  //           )),
                                  //         ),
                                  //         const Spacer(
                                  //           flex: 10,
                                  //         ),
                                  //         Icon(
                                  //           isOpen
                                  //               ? Icons.keyboard_arrow_up_sharp
                                  //               : Icons
                                  //                   .keyboard_arrow_down_sharp,
                                  //           color: Colors.white,
                                  //         ),
                                  //         const Spacer(
                                  //           flex: 1,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // ),
                                  // if (isOpen)
                                  //   ListView(
                                  //     primary: true,
                                  //     shrinkWrap: true,
                                  //     children: colleges
                                  //         .map((e) => Container(
                                  //               decoration: BoxDecoration(
                                  //                 color: selectOption == e
                                  //                     ? AppColors.primary
                                  //                         .withAlpha(100)
                                  //                     : Colors.white,
                                  //                 borderRadius:
                                  //                     const BorderRadius.all(
                                  //                   Radius.circular(25.0),
                                  //                 ),
                                  //                 border: Border.all(
                                  //                   color: AppColors.primary
                                  //                       .withAlpha(100),
                                  //                   width: 5.0,
                                  //                 ),
                                  //               ),
                                  //               child: Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.all(8.0),
                                  //                 child: InkWell(
                                  //                   onTap: () {
                                  //                     selectOption = e;
                                  //                     setState(() {
                                  //                       isOpen = false;
                                  //                     });
                                  //                   },
                                  //                   child: Text(e),
                                  //                 ),
                                  //               ),
                                  //             ))
                                  //         .toList(),
                                  //   ),
                                  if (!isOpen)
                                    AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 1000,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: LoginSignUpTextField(
                                            'Enter College Name',
                                            Icons.school,
                                            controller: othercollegeController,
                                            obscureText: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const YearSelectRadioTile(),
                            LoginSignUpTextField(
                              'Email',
                              Icons.email_outlined,
                              controller: emailController,
                              obscureText: false,
                            ),
                            LoginSignUpTextField(
                              'Password',
                              Icons.lock_outline,
                              controller: passwordController,
                              obscureText: true,
                            ),
                            LoginSignUpTextField(
                              'Confirm Password',
                              Icons.lock_outline,
                              controller: passwordConfirmController,
                              obscureText: true,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    // image: const DecorationImage(
                                    // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7),BlendMode.dstATop),
                                    // image: AssetImage(
                                    //   'assets/images/pumpkin.png',
                                    // ),
                                    // fit: BoxFit.fill,
                                    // ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 90,
                                      top: 30,
                                    ),
                                    height: 100,
                                    width: 700,
                                    child: HalloweenButton(
                                      buttonText: 'SIGN UP',
                                      icon: Icons.sign_language,
                                      onPressed: () async {
                                        if (passwordController.text !=
                                            passwordConfirmController.text) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Passwords do not match",
                                                style: AppStyles.NormalText()
                                                    .copyWith(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor: const Color.fromARGB(
                                                  255, 78, 48, 21),
                                            ),
                                          );

                                          return;
                                        }

                                        collegeController.text =
                                            selectOption == 'Other'
                                                ? othercollegeController.text
                                                : "PICT";

                                        if (firstNameController.text.isEmpty ||
                                            lastNameController.text.isEmpty ||
                                            phoneController.text.isEmpty ||
                                            collegeController.text.isEmpty ||
                                            emailController.text.isEmpty ||
                                            passwordController.text.isEmpty ||
                                            passwordConfirmController
                                                .text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Please fill all fields",
                                                style: AppStyles.NormalText()
                                                    .copyWith(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor: const Color.fromARGB(
                                                  255, 78, 48, 21),
                                            ),
                                          );

                                          return;
                                        }
                                        if (passwordController.text.length <
                                            8) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Password should be atleast 8 characters long",
                                                style: AppStyles.NormalText()
                                                    .copyWith(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor: const Color.fromARGB(
                                                  255, 78, 48, 21),
                                            ),
                                          );

                                          return;
                                        }
                                        if (phoneController.text.length != 10) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                  "Phone number should be 10 digits long",
                                                  style: AppStyles.NormalText()
                                                      .copyWith(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor: const Color.fromARGB(
                                                    255, 78, 48, 21)),
                                          );

                                          return;
                                        }
                                        final RegExp emailRegex = RegExp(
                                          r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                                        );
                                        if (!emailRegex
                                            .hasMatch(emailController.text)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Please enter a valid email",
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 78, 48, 21),
                                            ),
                                          );

                                          return;
                                        }
                                        final RegExp phoneRegex =
                                            RegExp(r'^[0-9]+$');
                                        if (!phoneRegex
                                            .hasMatch(phoneController.text)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Please enter a valid phone number",
                                                style: AppStyles.NormalText()
                                                    .copyWith(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor: const Color.fromARGB(
                                                  255, 78, 48, 21),
                                            ),
                                          );

                                          return;
                                        }
                                        await context
                                            .read<SignUpCubit>()
                                            .signUp(
                                              college:
                                                  collegeController.text.trim(),
                                              email:
                                                  emailController.text.trim(),
                                              firstName: firstNameController
                                                  .text
                                                  .trim(),
                                              lastName: lastNameController.text
                                                  .trim(),
                                              password: passwordController.text
                                                  .trim(),
                                              phone:
                                                  phoneController.text.trim(),
                                              year: YearSelectRadioTile
                                                  .yearOfStudyString,
                                              country: address,
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                ),
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromARGB(255, 228, 188, 136),
                  title: Text(
                    'FE',
                    style: AppStyles.NormalText().copyWith(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                ),
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromARGB(255, 228, 188, 136),
                  title: Text(
                    'SE',
                    style: AppStyles.NormalText().copyWith(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
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
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                ),
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromARGB(255, 228, 188, 136),
                  title: Text(
                    'TE',
                    style: AppStyles.NormalText().copyWith(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                ),
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color.fromARGB(255, 228, 188, 136),
                  title: Text(
                    'BE',
                    style: AppStyles.NormalText().copyWith(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
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
            ),
          ],
        ),
      ],
    );
  }
}

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController passwordConfirmController =
//       TextEditingController();
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController collegeController = TextEditingController();
//   final TextEditingController othercollegeController = TextEditingController();
//
//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     passwordConfirmController.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     phoneController.dispose();
//     collegeController.dispose();
//   }
//
//   bool isOpen = false;
//   String selectOption = 'Select College';
//   // late String? valueChoose;
//   List<String> colleges = ["PICT", "Other"];
//   String countryValue = "";
//   String address = "Country";
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         Panorama(
//           sensitivity: 0.4,
//           animSpeed: 0.5,
//           sensorControl: SensorControl.Orientation,
//           child: Image.asset(AppImages.spaceBackground, fit: BoxFit.cover),
//         ),
//         Scaffold(
//           resizeToAvoidBottomInset: true,
//           appBar: AppBar(
//             elevation: 0,
//             leading: GoBackButton(context),
//             backgroundColor: Colors.transparent,
//           ),
//           backgroundColor: Colors.transparent,
//           body: BlocConsumer<SignUpCubit, SignUpState>(
//             listener: (context, state) async {
//               if (state is SignUpSuccess) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Sign Up Successful"),
//                     backgroundColor: Colors.green,
//                   ),
//                 );
//                 await context.read<CheckLoginCubit>().checkLogin();
//                 if (context.mounted) {
//                   while (Navigator.canPop(context)) {
//                     Navigator.pop(context);
//                   }
//                 }
//
//                 return;
//               }
//               if (state is SignUpFailure) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.message),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//
//                 return;
//               }
//               if (state is SignUpError) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.message),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//
//                 return;
//               }
//             },
//             builder: (context, state) {
//               return state is SignUpLoading
//                   ? const Center(child: Loader())
//                   : SingleChildScrollView(
//                       child: Container(
//                         margin: const EdgeInsets.only(
//                           top: 20,
//                           left: 20,
//                           right: 20,
//                           bottom: 20,
//                         ),
//                         height: MediaQuery.of(context).size.height,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Create Account',
//                               style: AppStyles.bodyTextStyle2()
//                                   .copyWith(fontSize: 30),
//                             ),
//                             Text(
//                               'Please fill the your information below.',
//                               style: AppStyles.bodyTextStyle3(),
//                             ),
//                             LoginSignUpTextField(
//                               'First Name',
//                               Icons.mode_edit_rounded,
//                               controller: firstNameController,
//                             ),
//                             LoginSignUpTextField(
//                               'Last Name',
//                               Icons.mode_edit_rounded,
//                               controller: lastNameController,
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   color: Colors.green,
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: CSCPicker(
//                                           // onCountryChanged: (country) {},
//
//                                           selectedItemStyle: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400),
//                                           onCountryChanged: (country) {
//                                             setState(() {
//                                               countryValue = country;
//                                               address = "$countryValue";
//                                             });
//                                           },
//
//                                           countryDropdownLabel: address,
//                                           countrySearchPlaceholder: address,
//                                           dropdownHeadingStyle: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 50,
//                                           ),
//
//                                           showCities: false,
//                                           showStates: false,
//                                           dropdownDecoration: BoxDecoration(
//                                             borderRadius:
//                                                 const BorderRadius.all(
//                                                     Radius.circular(25.0)),
//                                             color: AppColors.primary
//                                                 .withAlpha(100),
//                                             border: Border.all(
//                                               color: Colors.black26,
//                                               width: 2.0,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       LoginSignUpTextField(
//                                         'Contact Number',
//                                         Icons.call,
//                                         controller: phoneController,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     isOpen = !isOpen;
//                                     setState(() {});
//                                   },
//                                   child: Container(
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.all(
//                                           Radius.circular(25.0)),
//                                       color: AppColors.primary.withAlpha(100),
//                                       border: Border.all(
//                                         color: Colors.black26,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     child: Row(
//                                       // mainAxisAlignment:
//                                       //     MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         SizedBox(
//                                           width: 8,
//                                         ),
//                                         Icon(
//                                           Icons.school_outlined,
//                                           color: Colors
//                                               .white, // add custom icons also
//                                         ),
//                                         SizedBox(
//                                           width: 15,
//                                         ),
//                                         Text(
//                                           selectOption,
//                                           style: (const TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 16)),
//                                         ),
//                                         SizedBox(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.6),
//                                         Icon(
//                                           isOpen
//                                               ? Icons.keyboard_arrow_up_sharp
//                                               : Icons.keyboard_arrow_down_sharp,
//                                           color: Colors.white,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 if (isOpen)
//                                   Padding(
//                                     padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                     child: ListView.separated(
// itemBuilder: (context, index){}                  primary: true,
//                                       shrinkWrap: true,
//                                       children: colleges
//                                           .map((e) => Container(
//                                                 decoration: BoxDecoration(
//                                                   color: selectOption == e
//                                                       ? AppColors.primary
//                                                           .withAlpha(100)
//                                                       : Colors.white,
//                                                   borderRadius:
//                                                       const BorderRadius.all(
//                                                           Radius.circular(
//                                                               70.0)),
//                                                   // color: AppColors.primary.withAlpha(100),
//                                                   border: Border.all(
//                                                     color: Colors.black26,
//                                                     width: 2.0,
//                                                   ),
//                                                 ),
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: InkWell(
//                                                       onTap: () {
//                                                         selectOption = e;
//                                                         setState(() {
//                                                           isOpen = false;
//                                                         });
//                                                       },
//                                                       child: Text(e)),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     ),
//                                   ),
//                                 if (selectOption == 'Other')
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: LoginSignUpTextField(
//                                       'enter college name',
//                                       Icons.school,
//                                       controller: othercollegeController,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                             const YearSelectRadioTile(),
//                             LoginSignUpTextField(
//                               'Email',
//                               Icons.email_outlined,
//                               controller: emailController,
//                             ),
//                             LoginSignUpTextField(
//                               'Password',
//                               Icons.lock_outline,
//                               controller: passwordController,
//                             ),
//                             LoginSignUpTextField(
//                               'Confirm Password',
//                               Icons.lock_outline,
//                               controller: passwordConfirmController,
//                             ),
//                             Center(
//                               child: RoundedButton(
//                                 btnText: 'SIGN UP',
//                                 onPressed: () async {
//                                   if (passwordController.text !=
//                                       passwordConfirmController.text) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text("Passwords do not match"),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//
//                                     return;
//                                   }
//                                   if (firstNameController.text.isEmpty ||
//                                       lastNameController.text.isEmpty ||
//                                       phoneController.text.isEmpty ||
//                                       collegeController.text.isEmpty ||
//                                       emailController.text.isEmpty ||
//                                       passwordController.text.isEmpty ||
//                                       passwordConfirmController.text.isEmpty) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text(
//                                           "Please fill all fields",
//                                         ),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//
//                                     return;
//                                   }
//                                   if (passwordController.text.length < 8) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text(
//                                           "Password should be atleast 8 characters long",
//                                         ),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//
//                                     return;
//                                   }
//                                   if (phoneController.text.length != 10) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text(
//                                           "Phone number should be 10 digits long",
//                                         ),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//
//                                     return;
//                                   }
//                                   final RegExp emailRegex = RegExp(
//                                     r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
//                                   );
//                                   if (!emailRegex
//                                       .hasMatch(emailController.text)) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text(
//                                           "Please enter a valid email",
//                                         ),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//
//                                     return;
//                                   }
//                                   final RegExp phoneRegex = RegExp(r'^[0-9]+$');
//                                   if (!phoneRegex
//                                       .hasMatch(phoneController.text)) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text(
//                                           "Please enter a valid phone number",
//                                         ),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//
//                                     return;
//                                   }
//                                   await context.read<SignUpCubit>().signUp(
//                                         college: collegeController.text.trim(),
//                                         email: emailController.text.trim(),
//                                         firstName:
//                                             firstNameController.text.trim(),
//                                         lastName:
//                                             lastNameController.text.trim(),
//                                         password:
//                                             passwordController.text.trim(),
//                                         phone: phoneController.text.trim(),
//                                         year: YearSelectRadioTile
//                                             .yearOfStudyString,
//                                         country: address,
//                                       );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ignore: must_be_immutable
// class YearSelectRadioTile extends StatefulWidget {
//   const YearSelectRadioTile({super.key});
//
//   static int yearOfStudy = 1;
//   static String yearOfStudyString = 'FE';
//
//   @override
//   State<YearSelectRadioTile> createState() => _YearSelectRadioTileState();
// }
//
// class _YearSelectRadioTileState extends State<YearSelectRadioTile> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.3,
//               child: Theme(
//                 data: ThemeData(
//                   unselectedWidgetColor: Colors.white,
//                 ),
//                 child: RadioListTile(
//                   contentPadding: EdgeInsets.zero,
//                   activeColor: AppColors.secondary,
//                   title: Text('FE', style: AppStyles.bodyTextStyle2()),
//                   value: 1,
//                   groupValue: YearSelectRadioTile.yearOfStudy,
//                   onChanged: (value) {
//                     setState(() {
//                       YearSelectRadioTile.yearOfStudy = value!;
//                       YearSelectRadioTile.yearOfStudyString = 'FE';
//                     });
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.3,
//               child: Theme(
//                 data: ThemeData(
//                   unselectedWidgetColor: Colors.white,
//                 ),
//                 child: RadioListTile(
//                   contentPadding: EdgeInsets.zero,
//                   activeColor: AppColors.secondary,
//                   title: Text('SE', style: AppStyles.bodyTextStyle2()),
//                   value: 2,
//                   groupValue: YearSelectRadioTile.yearOfStudy,
//                   onChanged: (value) {
//                     setState(() {
//                       YearSelectRadioTile.yearOfStudy = value!;
//                       YearSelectRadioTile.yearOfStudyString = 'SE';
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.3,
//               child: Theme(
//                 data: ThemeData(
//                   unselectedWidgetColor: Colors.white,
//                 ),
//                 child: RadioListTile(
//                   contentPadding: EdgeInsets.zero,
//                   activeColor: AppColors.secondary,
//                   title: Text('TE', style: AppStyles.bodyTextStyle2()),
//                   value: 3,
//                   groupValue: YearSelectRadioTile.yearOfStudy,
//                   onChanged: (value) {
//                     setState(() {
//                       YearSelectRadioTile.yearOfStudy = value!;
//                       YearSelectRadioTile.yearOfStudyString = 'TE';
//                     });
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.3,
//               child: Theme(
//                 data: ThemeData(
//                   unselectedWidgetColor: Colors.white,
//                 ),
//                 child: RadioListTile(
//                   contentPadding: EdgeInsets.zero,
//                   activeColor: AppColors.secondary,
//                   title: Text('BE', style: AppStyles.bodyTextStyle2()),
//                   value: 4,
//                   groupValue: YearSelectRadioTile.yearOfStudy,
//                   onChanged: (value) {
//                     setState(() {
//                       YearSelectRadioTile.yearOfStudy = value!;
//                       YearSelectRadioTile.yearOfStudyString = 'BE';
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
