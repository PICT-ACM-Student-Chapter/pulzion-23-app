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
    emit(CartPageLoading());

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

  Future<void> addCartItem(int id) async {
    emit(CartPageLoading());
    Response? response;
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      response = await http.post(
        Uri.parse(EndPoints.cart),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'event_id': id}),
      );

      var data = jsonDecode(response.body);

      if ((response.statusCode / 100).floor() == 2) {
        log('Add item response status code: ${response.statusCode}');
        log('Add item response data message: ${data['msg']}');
        emit(CartItemAdded(data['msg'].toString()));
      } else {
        log('Add item response status code: ${response.statusCode}');
        log('Add item response error: ${data['error']}');
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
  //sendtransactionid -> 1. sending 2. sent 3. error
  // http post req: 1. [event id] 2. transaction id
  // button for transaction id

  List<int> getTransactionID() {
    List<int> event_id = [];
    for (var cartItem in eventList.cartItems!) {
      event_id.add(cartItem.id!);
    }

    return event_id;
  }

  Future<void> sendTransactionID(String tr_id) async {
    // emit(CartEmpty());
    emit(SendingTransaction());
    try {
      final response = await http.post(
        Uri.parse(EndPoints.transaction),
        body: jsonEncode({
          'event_id': getTransactionID(),
          'transaction_id': tr_id,
        }),
      );
      var data = jsonDecode(response.body);
      
      print("ERROR IS " + data['error']);
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
}
