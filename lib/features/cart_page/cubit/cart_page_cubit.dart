import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants/models/cart_model.dart';
import '../../../constants/static_objects.dart';
import '../../../constants/urls.dart';

part 'cart_page_state.dart';

class CartPageCubit extends Cubit<CartPageState> {
  CartPageCubit() : super(CartPageLoading());

  Future<void> loadCart() async {
    emit(CartPageLoading());

    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    if (token == null) {
      loadCart();
    } else {
      try {
        var response = await http.get(
          Uri.parse(EndPoints.cart),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        var data = jsonDecode(response.body);
        CartItemList eventList = CartItemList.fromJson(data);
        log(data.toString());
        emit(CartPageLoaded(eventList));
      } catch (e) {
        log(e.toString());
        emit(CartPageError(e.toString()));
      }
    }
  }

  Future<void> addCartItem(int id) async {
    emit(CartPageLoading());
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      var response = await http.post(
        Uri.parse(EndPoints.cart),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'event_id': id}),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 400) {
        emit(CartItemNotAdded(data['error']));
      }
      emit(CartItemAdded(jsonDecode(response.body)['msg']));
    } catch (e) {
      log(e.toString());
      emit(CartItemNotAdded(e.toString()));
    }
  }

  Future<void> deleteItem(int id) async {
    emit(CartPageLoading());
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      var response = await http.post(
        Uri.parse('${EndPoints.cart}$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      log(response.body);
      emit(CartItemDeleted('Item deleted from cart'));
    } catch (e) {
      log(e.toString());
      emit(CartItemNotDeleted(e.toString()));
    }
  }
}
