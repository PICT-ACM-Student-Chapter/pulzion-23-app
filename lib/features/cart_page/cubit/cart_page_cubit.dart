import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../constants/models/cart_model.dart';
import '../../../constants/urls.dart';

part 'cart_page_state.dart';

class CartPageCubit extends Cubit<CartPageState> {
  late CartItemList eventList;
  CartPageCubit() : super(CartPageLoading());

  Future<void> loadCart() async {
    // emit(CartPageLoading());
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token != null) {
      Response? response;
      try {
        response = await http.get(
          Uri.parse(EndPoints.cart),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        var data = jsonDecode(response.body);
        if ((response.statusCode / 100).floor() == 2) {
          log('Load cart response status code: ${response.statusCode}');
          log('Load cart response data: $data');
          eventList = CartItemList.fromJson(data);
          emit(CartPageLoaded(eventList));
        } else if (response.statusCode == 404) {
          log('Load cart response status code: ${response.statusCode}');
          log('Load cart response error: ${data['error']}');
          emit(CartEmpty());
        } else {
          log('Load cart response status code: ${response.statusCode}');
          log('Load cart response error: ${data['error']}');
          emit(CartPageError(data['error'].toString()));
        }
      } catch (e) {
        if (response == null) {
          log('Load cart exception: $e');
          emit(CartPageError('Failed host lookup.'));
        } else {
          log('Load cart exception: $e');
          emit(CartPageError(e.toString()));
        }
      }
    } else {
      emit(CartPageError('Logout and login again.'));
    }
  }

  Future<void> registerFreeEvent(int id, BuildContext context) async {
    emit(CartPageLoading());
    Response? response;
    final sc = ScaffoldMessenger.of(context);
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      response = await http.post(
        Uri.parse(EndPoints.userEvents),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'event_id': id}),
      );
      log(response.body.toString());
      var data = jsonDecode(response.body);

      if ((response.statusCode / 100).floor() == 2) {
        sc.hideCurrentSnackBar();
        sc.showSnackBar(
          const SnackBar(
            content: Text('Registered Successfully'),
            backgroundColor: Color.fromARGB(255, 196, 117, 15),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        sc.showSnackBar(
          SnackBar(
            content: Text(data['msg']),
            backgroundColor: const Color.fromARGB(255, 78, 48, 21),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration Failed'),
          backgroundColor: Color.fromARGB(255, 78, 48, 21),
        ),
      );
    }
  }

  Future<void> addCombo(int comboId) async {
    emit(CartPageLoading());
    Response? response;
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      log('this is endpoint = ${EndPoints.combos}$comboId');
      response = await http.post(
        Uri.parse('${EndPoints.combos}$comboId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      log('data = ${response.body}');
      var data = jsonDecode(response.body);

      if ((response.statusCode / 100).floor() == 2) {
        log('Add item response status code: ${response.statusCode}');
        log('Add item response data message: ${data['msg']}');
        emit(CartItemAdded(data['msg'].toString()));
      } else {
        log('Add combo response status code: ${response.statusCode}');
        log('Add combo response error: ${data['error']}');
        emit(CartItemNotAdded(data['error'].toString()));
      }
    } catch (e) {
      if (response == null) {
        log('Load cart exception: $e');
        emit(CartPageError('Failed host lookup.'));
      } else {
        log('Load cart exception: $e');
        emit(CartPageError(e.toString()));
      }
    }
  }

  Future<void> deleteCombo(int comboId) async {
    emit(CartPageLoading());
    Response? response;
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      response = await http.delete(
        Uri.parse('${EndPoints.combos}$comboId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var data = jsonDecode(response.body);

      if ((response.statusCode / 100).floor() == 2) {
        log('Delete response status code: ${response.statusCode}');
        log('Delete response data message: ${data['msg']}');
        emit(CartItemDeleted(data['msg'].toString()));
      } else {
        log('Delete response status code: ${response.statusCode}');
        log('Delete response error: ${data['error']}');
        emit(CartItemNotDeleted(data['error'].toString()));
      }
    } catch (e) {
      if (response == null) {
        log('Load cart exception: $e');
        emit(CartPageError('Failed host lookup.'));
      } else {
        log('Load cart exception: $e');
        emit(CartPageError(e.toString()));
      }
    }
  }

  Future<bool> addCartItem(int id) async {
    emit(CartPageLoading());
    Response? response;
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      response = await http.post(
        Uri.parse(
          id == 1 ? EndPoints.userRegister : EndPoints.cart,
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(
          {'event_id': id},
        ),
      );

      var data = jsonDecode(response.body);

      if ((response.statusCode / 100).floor() == 2) {
        log('Add item response status code: ${response.statusCode}');
        log('Add item response data message: ${data['msg']}');
        emit(CartItemAdded(data['msg'].toString()));

        return true;
      } else {
        log('Add item response status code: ${response.statusCode}');
        log('Add item response error: ${data['error']}');
        emit(CartItemNotAdded(data['error'].toString()));

        return false;
      }
    } catch (e) {
      if (response == null) {
        log('Load cart exception: $e');
        emit(CartPageError('Failed host lookup.'));
      } else {
        log('Load cart exception: $e');
        emit(CartPageError(e.toString()));
      }

      return false;
    }
  }
  //sendtransactionid -> 1. sending 2. sent 3. error
  // http post req: 1. [event id] 2. transaction id
  // button for transaction id

  List<List<int>> getTransactionID() {
    List<int> eventId = [];
    List<int> comboId = [];
    for (var cartItem in eventList.cartItems!) {
      eventId.add(cartItem.id!);
    }
    for (var comboItem in eventList.cartCombos!) {
      comboId.add(comboItem.comboID!);
    }

    return [eventId, comboId];
  }

  Future<void> sendTransactionID(String trId, String? referral) async {
    emit(SendingTransaction());
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      final transactions = getTransactionID();

      final response = await http.post(
        Uri.parse(EndPoints.transaction),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'event_id': transactions[0],
          'transaction_id': trId,
          'combo_id': transactions[1],
          // 'referal_code': referral ?? '',
        }),
      );
      var data = jsonDecode(response.body);
      log(data.toString());
      if (data['error'] != null) {
        emit(TransactionError(data['error'].toString()));
      }
      if (data['message'] == "Form submitted successfully") {
        clearCart().then((value) => emit(CartEmpty()));
      } else if (data['message'] == "Something went wrong") {
        emit(TransactionError("Transaction failed!"));
      }
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    emit(CartPageLoading());
    Response? response;
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      response = await http.delete(
        Uri.parse(EndPoints.cart),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var data = jsonDecode(response.body);

      if ((response.statusCode / 100).floor() == 2) {
        log('Delete response status code: ${response.statusCode}');
        log('Delete response data message: ${data['msg']}');
        emit(CartItemDeleted(data['msg'].toString()));
      } else {
        log('Delete response status code: ${response.statusCode}');
        log('Delete response error: ${data['error']}');
        emit(CartItemNotDeleted(data['error'].toString()));
      }
    } catch (e) {
      if (response == null) {
        log('Load cart exception: $e');
        emit(CartPageError('Failed host lookup.'));
      } else {
        log('Load cart exception: $e');
        emit(CartPageError(e.toString()));
      }
    }
  }

  Future<void> deleteItem(int id) async {
    emit(CartPageLoading());
    Response? response;
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      response = await http.delete(
        Uri.parse('${EndPoints.cart}$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      var data = jsonDecode(response.body);

      if ((response.statusCode / 100).floor() == 2) {
        log('Delete response status code: ${response.statusCode}');
        log('Delete response data message: ${data['msg']}');
        emit(CartItemDeleted(data['msg'].toString()));
      } else {
        log('Delete response status code: ${response.statusCode}');
        log('Delete response error: ${data['error']}');
        emit(CartItemNotDeleted(data['error'].toString()));
      }
    } catch (e) {
      if (response == null) {
        log('Load cart exception: $e');
        emit(CartPageError('Failed host lookup.'));
      } else {
        log('Load cart exception: $e');
        emit(CartPageError(e.toString()));
      }
    }
  }

  Future<List<String>> getReferralCodes() async {
    try {
      final response = await http.get(
        Uri.parse(
          EndPoints.referralLink ?? '',
        ),
      );

      var data = jsonDecode(response.body)['refreal'];
      List<String> codes = ['N/A'];
      for (var i in data) {
        codes.add(i['code']);
      }
      log(codes.toString());

      return codes;
    } catch (e) {
      log(e.toString());

      return [];
    }
  }
}
