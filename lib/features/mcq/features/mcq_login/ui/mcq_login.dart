import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/mcq/features/event_list/logic/cubit/mcq_event_list_cubit.dart';
import 'package:pulzion23/features/mcq/features/event_list/ui/event_list.dart';
import 'package:pulzion23/features/mcq/features/mcq_login/logic/cubit/mcq_login_cubit.dart';
import 'package:pulzion23/features/mcq/features/question_page/logic/cubit/question_page_cubit.dart';

class MCQLogin extends StatefulWidget {
  const MCQLogin({
    super.key,
  });

  @override
  State<MCQLogin> createState() => _McqLoginState();
}

class _McqLoginState extends State<MCQLogin> {
  final String _error = '';
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailid = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

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
                color: const Color.fromRGBO(228, 176, 77, 1),
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
                left: 15.0,
                right: 15.0,
                top: 15.0,
                bottom: 15.0,
              ),
              child: TextFormField(
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                validator: (input) {
                  return isEmail(input!) ? null : "Please Enter Correct Email.";
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
                  fillColor: const Color.fromRGBO(228, 176, 77, 1),
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
                child: BlocBuilder<McqLoginCubit, McqLoginState>(
                  builder: (context, state) {
                    return TextFormField(
                      autocorrect: true,
                      obscureText: state is! McqLoginShowPass,
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
                          child: (state is McqLoginShowPass)
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                ),
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
                        fillColor: const Color.fromRGBO(228, 176, 77, 1),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
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
            BlocConsumer<McqLoginCubit, McqLoginState>(
              listener: (context, state) {
                if (state is McqLoginSuccess) {
                  Fluttertoast.showToast(
                    msg: 'Login-in Successful',
                    backgroundColor: Colors.blue.shade600,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => EventListCubit()..loadEventPage(),
                        child: const McqEventList(),
                      ),
                    ),
                  );
                }
                if (state is McqLoginError) {
                  Fluttertoast.showToast(
                    msg: state.error.toString(),
                    backgroundColor: Colors.blue.shade600,
                  );
                }
              },
              builder: (context, state) {
                return state is McqLoginLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.white),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 123, 71, 16),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Color.fromARGB(255, 155, 119, 88),
                              width: 1,
                            ),
                          ),
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
                                  fontSize: 25,
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
