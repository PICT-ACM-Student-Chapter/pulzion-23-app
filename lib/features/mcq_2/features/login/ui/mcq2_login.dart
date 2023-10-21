import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/mcq/presentation/pages/event_list.dart';
import 'package:pulzion23/features/mcq_2/features/login/logic/cubit/mcq2_login_cubit.dart';

class McqLogin extends StatefulWidget {
  McqLogin({Key? key});

  @override
  State<McqLogin> createState() => _McqLoginState();
}

class _McqLoginState extends State<McqLogin> {
  final String _error = '';

  final GlobalKey<FormState> _formKey = GlobalKey();

  // final String _initialCountry = 'IN';

  // final PhoneNumber _number = PhoneNumber(isoCode: 'IN');

  final TextEditingController _emailid = TextEditingController();

  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height * 0.15,
            ),
            Text(
              "Login For MCQs",
              style: AppStyles.bodyTextStyle2().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
              child: TextFormField(
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                validator: (input) {
                  return context.read<Mcq2_LoginCubit>().isEmail(input!)
                      ? null
                      : "Please Enter Correct Email.";
                },
                style: const TextStyle(color: Colors.white),
                controller: _emailid,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontSize: height * 0.02,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xff46526d),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
              child: SizedBox(
                height: 80,
                child: BlocBuilder<Mcq2_LoginCubit, Mcq2_LoginState>(
                  builder: (context, state) {
                    return TextFormField(
                      autocorrect: true,
                      obscureText: state is! Mcq2_LoginShowPass,
                      validator: (val) => val!.isEmpty
                          ? 'Please enter password'
                          : (val.length < 8
                              ? 'Password must be at least 8 characters long!'
                              : null),
                      style: const TextStyle(
                        color: AppColors.white,
                      ),
                      controller: _pass,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          child: (state is Mcq2_LoginShowPass)
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(Icons.visibility_off,
                                  color: Colors.black),
                          onTap: () {
                            context.read<Mcq2_LoginCubit>().toggleHideInput();
                          },
                        ),
                        hintStyle: TextStyle(
                          fontSize: height * 0.02,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xff46526d),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Text(
                _error,
                style: TextStyle(color: Colors.red, fontSize: height * 0.04),
              ),
            ),
            BlocConsumer<Mcq2_LoginCubit, Mcq2_LoginState>(
              listener: (context, state) {
                if (state is Mcq2_LoginSuccess) {
                  Fluttertoast.showToast(
                    msg: 'Login-in Successful',
                    backgroundColor: Colors.blue.shade600,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MCQEventList(),
                    ),
                  );
                }
                if (state is Mcq2_LoginError) {
                  log(state.error.toString());
                  Fluttertoast.showToast(
                    msg: state.error.toString(),
                    backgroundColor: Colors.blue.shade600,
                  );
                }
              },
              builder: (context, state) {
                return state is Mcq2_LoginLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.white),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(200),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          border: const Border.fromBorderSide(BorderSide(
                              color: AppColors.cardBorder, width: 1)),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await context
                                  .read<Mcq2_LoginCubit>()
                                  .loginUser(_emailid.text, _pass.text);
                            }
                          },
                          child: Center(
                            child: Center(
                              child: Text(
                                "Login",
                                style: AppStyles.bodyTextStyle5().copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
