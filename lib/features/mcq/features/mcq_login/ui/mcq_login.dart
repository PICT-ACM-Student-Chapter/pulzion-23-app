import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';
import 'package:pulzion23/features/login_page/ui/widgets/text_field.dart';
import 'package:pulzion23/features/mcq/features/event_list/logic/cubit/mcq_event_list_cubit.dart';
import 'package:pulzion23/features/mcq/features/event_list/ui/event_list.dart';
import 'package:pulzion23/features/mcq/features/mcq_login/logic/cubit/mcq_login_cubit.dart';

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
              style: AppStyles.TitleText().copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w100,
                fontSize: 70,
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
              child: LoginSignUpTextField(
                'Username',
                Icons.email,
                controller: _emailid,
                obscureText: false,
                validator: (input) {
                  return isEmail(input!) ? null : "Please Enter Correct Email.";
                },
              ),
              // TextFormField(
              //   autocorrect: false,
              //   textCapitalization: TextCapitalization.none,
              //   enableSuggestions: false,
              //   keyboardType: TextInputType.emailAddress,
              //   validator: (input) {
              //     return isEmail(input!) ? null : "Please Enter Correct Email.";
              //   },
              //   style: const TextStyle(color: Colors.white),
              //   controller: _emailid,
              //   decoration: InputDecoration(
              //     icon: const Icon(
              //       Icons.email,
              //       color: Colors.white,
              //     ),
              //     hintText: 'Email',
              //     hintStyle: TextStyle(
              //       fontSize: height * 0.02,
              //       color: Colors.white,
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(25),
              //       borderSide: const BorderSide(
              //         width: 0,
              //         style: BorderStyle.none,
              //       ),
              //     ),
              //     filled: true,
              //     fillColor: const Color.fromRGBO(228, 176, 77, 1),
              //     contentPadding:
              //         const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              //   ),
              // ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
              child: BlocBuilder<McqLoginCubit, McqLoginState>(
                builder: (context, state) {
                  return LoginSignUpTextField(
                    'Password',
                    Icons.lock,
                    controller: _pass,
                    obscureText: true,
                  );
                },
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
                    : SizedBox(
                        height: 200,
                        width: 300,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.2,
                          ),
                          child: HalloweenButton(
                            icon: Icons.login,
                            buttonText: "Login",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await context
                                    .read<McqLoginCubit>()
                                    .loginUser(_emailid.text, _pass.text);
                              }
                            },
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
