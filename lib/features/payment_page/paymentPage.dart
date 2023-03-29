import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/features/payment_page/paymentSuccess.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constants/urls.dart';

void main() => runApp(Payment());


@override
Future<http.Response> postRequest (final String a1) async {
  var url =EndPoints.paymentURL;
  const storage = FlutterSecureStorage();
  var token = await storage.read(key:'token');

  //late var a;
  Map data = {
    'TransactionId': '${a1}'
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url as Uri,
      headers: {"Content-Type": "application/json",
      'Authorization': "Bearer $token",
      },
      

      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}
class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  String a = "";
  final url = Uri.parse("upi://pay?pa=tarunsantani2003-1@oksbi&pn=PICT ACM Student Chapter&am=" +
      "20"+
      "&tn=Pasc&cu=INR");//yaha replace 20 with amount jo aayega cart se...
  TextEditingController controller  = TextEditingController();
  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    // ignore: newline-before-return
    return MaterialApp(
      home: Stack(
        children: [ 
          Panorama(
          animSpeed: 0.5,
          sensorControl: SensorControl.Orientation,
          child: Image.asset('assets/images/space_bg.jpg', fit: BoxFit.cover),
        ),
          Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Center(
                child: Container(
                  color: Colors.transparent,
                  height: height * 0.3,
                  width: width * 0.5,
                  child: QrImage(
                    data: url.toString(),
                    size: width * 0.5,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              // SizedBox(
              //   height: height * 0.05,
              // ),
              Center(
                child: Container(
                  width: width * 0.8,
                  color: Colors.transparent,
                  child: TextFormField(
      
                    controller: controller,
                    
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      
                      labelText: "Enter Transaction ID",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                setState(() {
                   a = controller.text;
                   postRequest(a);
                   print(postRequest(a));

                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentSuccess()));
              }, child:  Text("Submit"),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),

          ),],
          ),
        ),
        ],
      ),
    );
  }
}
