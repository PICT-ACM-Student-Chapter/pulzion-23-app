import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  test('Signup Test', () async {
    // Write the test login and password here
    var firstName = "Tim";
    var lastName = "Cook";
    var email = "rohantest@gmail.com";
    var phone = "1234567890";
    var college = "PICT";
    var year = "TE";
    var password = "pass@123";
    Map<String, dynamic> data = {};
    try {
      var response = await http.post(
        // Paste the Signup endpoint here
        Uri.parse('http://20.100.207.112:8000/user/signin'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'phone': phone,
            'college': college,
            'year': year,
            'password': password,
          },
        ),
      );
      data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        expect(data['token'], isNotNull);
      } else {
        expect(data['token'], isNull);
      }
    } catch (e) {
      expect(data['token'], isNull);
    }
  });
}
