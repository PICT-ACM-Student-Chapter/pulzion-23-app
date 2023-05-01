import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pulzion23/constants/styles.dart';
// import 'package:pulzion22_app/constants/constants.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/images.dart';
import '../../../../constants/mcqconstants.dart';
import '../../../../services/mcq_user_provider.dart';
import 'event_list.dart';

class McqLogin extends StatefulWidget {
  const McqLogin({Key? key}) : super(key: key);

  @override
  _McqLoginState createState() => _McqLoginState();
}

class _McqLoginState extends State<McqLogin> {
  Future<void> _loginUser(String email, String password) async {
    const storage = FlutterSecureStorage();
    try {
      Map data = {"email": email, "password": password};
      final response = await http.post(
        Uri.parse(Constants.MCQ_LOGIN),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        await storage.write(key: 'mcqtoken', value: result['access']);
        final value = Provider.of<MCQUserProvider>(context, listen: false);
        value.setToken(result['access']);
        Fluttertoast.showToast(
          msg: 'Login-in Successful',
          backgroundColor: Colors.blue.shade600,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MCQEventList(),
          ),
        );
      } else {
        var result = jsonDecode(response.body);
        var error = result['error'] ?? "Login Failed!";
        throw error;
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.blue.shade600,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _email = '';
  String password = '';
  String _inputPassword = "";
  String _error = '';
  bool _hidePassword = true;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  String _initialCountry = 'IN';
  PhoneNumber _number = PhoneNumber(isoCode: 'IN');

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
              "Login",
              style: AppStyles.bodyTextStyle2().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
              child: TextFormField(
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                validator: (input) {
                  if (isEmail(input!)) {
                    setState(() {
                      _emailid.text = input;
                    });
                  }

                  return null;
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
              child: SizedBox(
                height: 80,
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      _inputPassword = val;
                    });
                  },
                  autocorrect: true,
                  obscureText: _hidePassword,
                  validator: (val) => val!.isEmpty
                      ? 'Please enter password'
                      : (val.length < 8 ? 'Password must be at least 8 characters long!' : null),
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
                      child: _hidePassword
                          ? const Icon(Icons.visibility_off, color: Colors.black)
                          : const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                      onTap: () {
                        _hidePassword = !_hidePassword;
                        setState(() {});
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                _error,
                style: TextStyle(color: Colors.red, fontSize: height * 0.04),
              ),
            ),
            !_isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(200),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: AppColors.cardBorder,
                          width: 1,
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          await _loginUser(_emailid.text, _pass.text);
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
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
