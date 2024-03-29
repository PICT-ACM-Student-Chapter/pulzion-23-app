import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';

import '../../../project/cubit/animation_toggle_cubit.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../constants/widgets/loader.dart';
import 'widgets/go_back_button.dart';

import '../../../constants/colors.dart';
import '../cubit/check_login_cubit.dart';
import '../logic/sign_up_cubit.dart';
import 'widgets/roundedbutton.dart';
import 'widgets/text_field.dart';
import 'package:csc_picker/csc_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
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

  bool isOpen = false;
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
            return Panorama(
              sensitivity: 0.4,
              animSpeed: 0.5,
              sensorControl: state ? SensorControl.Orientation : SensorControl.None,
              child: Image.asset(
                AppImages.spaceBackground,
                fit: BoxFit.cover,
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
                  const SnackBar(
                    content: Text("Sign Up Successful"),
                    backgroundColor: Colors.green,
                  ),
                );
                await context.read<CheckLoginCubit>().checkLogin();
                if (context.mounted) {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
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
              return state is SignUpLoading
                  ? const Center(child: Loader())
                  : SingleChildScrollView(
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
                              style: AppStyles.bodyTextStyle2().copyWith(fontSize: 30),
                            ),
                            Text(
                              'Please fill the your information below.',
                              style: AppStyles.bodyTextStyle3(),
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
                            CSCPicker(
                              // defaultCountry: CscCountry.India,
                              selectedItemStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              onCountryChanged: (country) {
                                setState(() {
                                  log(country.toString());
                                  countryValue = country;
                                  address = countryValue;
                                });
                              },
                              countryDropdownLabel: address,
                              countrySearchPlaceholder: address,
                              dropdownHeadingStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              showCities: false,
                              showStates: false,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                                color: AppColors.primary.withAlpha(100),
                                border: Border.all(
                                  color: Colors.black26,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            LoginSignUpTextField(
                              'Contact Number',
                              Icons.call,
                              controller: phoneController,
                              obscureText: false,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () => {
                                    setState(() {
                                      isOpen = !isOpen;
                                    }),
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(25.0),
                                      ),
                                      color: AppColors.primary.withAlpha(100),
                                      border: Border.all(
                                        color: Colors.black26,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Icon(
                                          Icons.school_outlined,
                                          color: Colors.white, // add custom icons also
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          selectOption,
                                          style: (const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          )),
                                        ),
                                        const Spacer(
                                          flex: 10,
                                        ),
                                        Icon(
                                          isOpen
                                              ? Icons.keyboard_arrow_up_sharp
                                              : Icons.keyboard_arrow_down_sharp,
                                          color: Colors.white,
                                        ),
                                        const Spacer(
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isOpen)
                                  ListView(
                                    primary: true,
                                    shrinkWrap: true,
                                    children: colleges
                                        .map((e) => Container(
                                              decoration: BoxDecoration(
                                                color: selectOption == e
                                                    ? AppColors.primary.withAlpha(100)
                                                    : Colors.white,
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(25.0),
                                                ),
                                                border: Border.all(
                                                  color: AppColors.primary.withAlpha(100),
                                                  width: 5.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    selectOption = e;
                                                    setState(() {
                                                      isOpen = false;
                                                    });
                                                  },
                                                  child: Text(e),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                if (selectOption == 'Other')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: LoginSignUpTextField(
                                      'enter college name',
                                      Icons.school,
                                      controller: othercollegeController,
                                      obscureText: false,
                                    ),
                                  ),
                              ],
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
                              child: RoundedButton(
                                btnText: 'SIGN UP',
                                onPressed: () async {
                                  if (passwordController.text != passwordConfirmController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Passwords do not match"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );

                                    return;
                                  }

                                  collegeController.text = selectOption == 'Other'
                                      ? othercollegeController.text
                                      : "PICT";

                                  if (firstNameController.text.isEmpty ||
                                      lastNameController.text.isEmpty ||
                                      phoneController.text.isEmpty ||
                                      collegeController.text.isEmpty ||
                                      emailController.text.isEmpty ||
                                      passwordController.text.isEmpty ||
                                      passwordConfirmController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please fill all fields",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );

                                    return;
                                  }
                                  if (passwordController.text.length < 8) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Password should be atleast 8 characters long",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );

                                    return;
                                  }
                                  if (phoneController.text.length != 10) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Phone number should be 10 digits long",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );

                                    return;
                                  }
                                  final RegExp emailRegex = RegExp(
                                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                                  );
                                  if (!emailRegex.hasMatch(emailController.text)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please enter a valid email",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );

                                    return;
                                  }
                                  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
                                  if (!phoneRegex.hasMatch(phoneController.text)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please enter a valid phone number",
                                        ),
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
                                        country: address,
                                      );
                                },
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                ),
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                ),
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