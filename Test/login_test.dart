import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

void main() {
  test('Login Test', () async {
    // Write the test login and password here
    var email = "timc@gmail.com";
    var password = "pass@123";
    Map<String, dynamic> data = {};
    try {
      var response = await http.post(
        // Paste the Login endpoint here
        Uri.parse('http://20.100.207.112:8000/user/signin'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        log("Login Success");
      } else {
        log("Login Failure");
      }
    } catch (e) {
      log("Login Error");
    }

    expect(data['token'], isNotNull);
  });
}
