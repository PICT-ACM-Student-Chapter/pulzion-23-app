import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/landing_page/ui/app_logo_image.dart';
import 'package:pulzion23/features/login_page/ui/go_back_button.dart';

import '../../../constants/colors.dart';
import 'roundedbutton.dart';
import 'login.dart';
import 'text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showSpinner = false;
  late String email;
  late String password;
  var yearOfStudy = 1;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Stack(
        children: [
          Image.asset(
            AppImages.spaceBackground,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              elevation: 0,
              leading: GoBackButton(context),
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
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
                    const LoginSignUpTextField('First Name', Icons.mode_edit_rounded),
                    const LoginSignUpTextField('Last Name', Icons.mode_edit_rounded),
                    const LoginSignUpTextField('Contact Number', Icons.call),
                    const LoginSignUpTextField('College Name', Icons.school),
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
                            groupValue: yearOfStudy,
                            onChanged: (value) {
                              setState(() {
                                yearOfStudy = value!;
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
                            groupValue: yearOfStudy,
                            onChanged: (value) {
                              setState(() {
                                yearOfStudy = value!;
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
                            groupValue: yearOfStudy,
                            onChanged: (value) {
                              setState(() {
                                yearOfStudy = value!;
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
                            groupValue: yearOfStudy,
                            onChanged: (value) {
                              setState(() {
                                yearOfStudy = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const LoginSignUpTextField('Email', Icons.email_outlined),
                    const LoginSignUpTextField('Password', Icons.lock_outline),
                    const LoginSignUpTextField('Confirm Password', Icons.lock_outline),
                    Center(
                      child: RoundedButton(
                        btnText: 'SIGN UP',
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
