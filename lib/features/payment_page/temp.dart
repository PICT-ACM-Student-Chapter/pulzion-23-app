import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/features/payment_page/cubit/payment_page_cubit_cubit.dart';
import 'package:pulzion23/features/payment_page/paymentSuccess.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:upi_india/upi_india.dart';

import '../../constants/urls.dart';

void main() => runApp(Payment());

@override
Future<http.Response> postRequest(final String a1) async {
  var url = EndPoints.paymentURL;
  const storage = FlutterSecureStorage();
  var token = await storage.read(key: 'token');

  //late var a;
  Map data = {'TransactionId': '${a1}'};
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url as Uri,
      headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      },
      body: body);
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
  // final url = Uri.parse("upi://pay?pa=tarunsantani2003-1@oksbi&pn=PICT ACM Student Chapter&am=" +
  //     "20"+
  //     "&tn=Pasc&cu=INR");//yaha replace 20 with amount jo aayega cart se..

  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "pictscholarship@jsb",
      receiverName: 'PICT ACM Student Chapter',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00, //yaha replace 1 with amount jo aayega cart se..
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

// String _upiErrorHandler(error) {
//     switch (error) {
//       case UpiIndiaAppNotInstalledException:
//         return 'Requested app not installed on device';
//       case UpiIndiaUserCancelledException:
//         return 'You cancelled the transaction';
//       case UpiIndiaNullResponseException:
//         return 'Requested app didn\'t return any response';
//       case UpiIndiaInvalidParametersException:
//         return 'Requested app cannot handle the transaction';
//       default:
//         return 'An Unknown error has occurred';
//     }
//   }

//   void _checkTxnStatus(String status) {
//     switch (status) {
//       case UpiPaymentStatus.SUCCESS:
//         print('Transaction Successful');
//         break;
//       case UpiPaymentStatus.SUBMITTED:
//         print('Transaction Submitted');
//         break;
//       case UpiPaymentStatus.FAILURE:
//         print('Transaction Failed');
//         break;
//       default:
//         print('Received an Unknown transaction status');
//     }
//   }

  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    @override
    Widget displayTransactionData(title, body) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$title: ", style: header),
            Flexible(
                child: Text(
              "$body",
              style: value,
            )),
          ],
          
        ),
      );
    }

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
            appBar: AppBar(
              title: Text('UPI'),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: displayUpiApps(),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _transaction,
                    builder: (BuildContext context,
                        AsyncSnapshot<UpiResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              _upiErrorHandler(snapshot.error.runtimeType),
                              style: header,
                            ), // Print's text message on screen
                          );
                        }

                        // If we have data then definitely we will have UpiResponse.
                        // It cannot be null
                        UpiResponse _upiResponse = snapshot.data!;

                        // Data in UpiResponse can be null. Check before printing
                        String txnId = _upiResponse.transactionId ?? 'N/A';
                        String resCode = _upiResponse.responseCode ?? 'N/A';
                        String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                        String status = _upiResponse.status ?? 'N/A';
                        String approvalRef =
                            _upiResponse.approvalRefNo ?? 'N/A';
                        BlocListener<PaymentStatusCubit, PaymentStatusCubit>(
                          listener: (context, state) {
                            // TODO: implement listener
                            PaymentPageCubitSuccess();
                          },
                          child: _checkTxnStatus(status),
                        );

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              displayTransactionData('Transaction Id', txnId),
                              displayTransactionData('Response Code', resCode),
                              displayTransactionData('Reference Id', txnRef),
                              displayTransactionData(
                                  'Status', status.toUpperCase()),
                              displayTransactionData(
                                  'Approval No', approvalRef),
                            ],
                          ),
                        );
                      } else
                        return Center(
                          child: Text(''),
                        );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
