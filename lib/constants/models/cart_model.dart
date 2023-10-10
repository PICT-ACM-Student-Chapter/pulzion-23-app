import 'dart:developer';

import 'package:pulzion23/features/combo_cubit/models/combo_model.dart';

class CartItemList {
  List<CartItem>? cartItems;
  List<Combo>? cartCombos;

  CartItemList({this.cartItems});

  CartItemList.fromJson(Map<String, dynamic> json) {
    if (json["events"] == null) {
      cartItems = null;
    } else {
      cartItems = [];
      cartCombos = [];
      json["events"]["events"].forEach((event) {
        final cItem = CartItem.fromJson(event);
        cartItems?.add(cItem);
      });
      json["events"]["combos"].forEach((event) {
        final cItem = Combo.fromJson(event);
        cartCombos?.add(cItem);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartItems != null) {
      data["events"] = cartItems?.map((e) => e.toJson()).toList();
    }

    return data;
  }

  List<int> getIds() {
    final List<int> ids = <int>[];
    cartItems?.forEach((element) {
      ids.add(element.id!);
    });

    return ids;
  }
}

class CartItem {
  int? id;
  String? name;
  int? price;
  String? logo;

  CartItem({
    this.id,
    this.name,
    this.price,
    this.logo,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    logo = json["logo"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["logo"] = logo;

    return data;
  }
}
