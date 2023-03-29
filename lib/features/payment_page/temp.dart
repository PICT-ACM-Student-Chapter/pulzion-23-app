// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:pulzion23/constants/urls.dart';

// Future<http.Response> postRequest () async {
//   var url =EndPoints.paymentURL;

//   Map data = {
//     'TransactionId': '${a}'
//   };
//   //encode Map to JSON
//   var body = json.encode(data);

//   var response = await http.post(url as Uri,
//       headers: {"Content-Type": "application/json"
//       },

//       body: body
//   );
//   print("${response.statusCode}");
//   print("${response.body}");
//   return response;
// }