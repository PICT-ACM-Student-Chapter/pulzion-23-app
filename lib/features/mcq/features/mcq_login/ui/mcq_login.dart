import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/mcq/features/event_list/ui/event_list.dart';
import 'package:pulzion23/features/mcq/features/mcq_login/logic/cubit/mcq_login_cubit.dart';

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
              style: AppStyles.NormalText().copyWith(
                color: Color.fromRGBO(228, 176, 77, 1),
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
                  return context.read<McqLoginCubit>().isEmail(input!)
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
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(228, 176, 77, 1),
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
                child: BlocBuilder<McqLoginCubit, Mcq_LoginState>(
                  builder: (context, state) {
                    return TextFormField(
                      autocorrect: true,
                      obscureText: state is! Mcq_LoginShowPass,
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
                          child: (state is Mcq_LoginShowPass)
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(Icons.visibility_off,
                                  color: Colors.black),
                          onTap: () {
                            context.read<McqLoginCubit>().toggleHideInput();
                          },
                        ),
                        hintStyle: TextStyle(
                          fontSize: height * 0.02,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(228, 176, 77, 1),
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
            BlocConsumer<McqLoginCubit, Mcq_LoginState>(
              listener: (context, state) {
                if (state is Mcq_LoginSuccess) {
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
                if (state is Mcq_LoginError) {
                  log(state.error.toString());
                  Fluttertoast.showToast(
                    msg: state.error.toString(),
                    backgroundColor: Colors.blue.shade600,
                  );
                }
              },
              builder: (context, state) {
                return state is Mcq_LoginLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.white),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 123, 71, 16),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          border: const Border.fromBorderSide(BorderSide(
                              color: AppColors.cardBorder, width: 1)),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await context
                                  .read<McqLoginCubit>()
                                  .loginUser(_emailid.text, _pass.text);
                            }
                          },
                          child: Center(
                            child: Center(
                              child: Text(
                                "Login",
                                style: AppStyles.NormalText().copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
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
