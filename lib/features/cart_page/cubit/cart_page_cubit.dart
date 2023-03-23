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
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(EndPoints.cart),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      var data = jsonDecode(response.body);
      CartItemList eventList = CartItemList.fromJson(data);
      log(eventList.cartItems.toString());
      emit(CartPageLoaded(eventList));
    } catch (e) {
      log(e.toString());
      emit(CartPageError());
    }
  }
}
