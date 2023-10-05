import 'dart:developer';

class Combo {
  String? comboName;
  int? comboID;
  String? comboTotalPrice;
  String? comboDiscountedPrice;
  bool? comboStatus;
  List<dynamic>? comboEventID;
  List<dynamic>? comboEventName;
  // Map<String, String>? terms_c;

  Combo({
    this.comboName,
    this.comboID,
    this.comboEventID,
    this.comboEventName,
    this.comboDiscountedPrice,
    this.comboStatus,
    this.comboTotalPrice,
    // this.terms_c,
  });

  Combo.fromJson(Map<String, dynamic> json) {
    comboID = json['id'];
    comboName = json['combo_name'];
    comboEventID = json['array_of_evid'];
    comboEventName = Combo.getComboEventName(json['array_of_evname']);
    comboTotalPrice = json['total_price'];
    comboDiscountedPrice = json['discounted_price'];
    comboStatus = json['status'];
    // terms_c = json['terms_c'];
  }

  static List<Combo> getComboList(List<dynamic>? json) {
    if (json == null || json == []) {
      return [];
    }
    List<Combo> l = [];
    for (var element in json) {
      final combo = Combo.fromJson(element);
      l.add(combo);
    }

    return l;
  }

  static List<dynamic>? getComboEventName(List<dynamic>? json) {
    if (json == null || json == []) {
      return [];
    }
    List<dynamic> l = [];
    for (var element in json) {
      l.add(element['name']);
    }

    return l;
  }
}
