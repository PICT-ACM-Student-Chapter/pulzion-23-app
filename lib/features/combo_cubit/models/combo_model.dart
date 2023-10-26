import 'dart:developer';

class ComboDetails {
  final String id;
  final String name;
  final String logo;

  ComboDetails({
    required this.id,
    required this.name,
    required this.logo,
  });
}

class Combo {
  String? comboName;
  int? comboID;
  String? comboTotalPrice;
  String? comboDiscountedPrice;
  bool? comboStatus;
  List<ComboDetails>? comboDetailsList;
  // Map<String, String>? terms_c;

  Combo({
    this.comboName,
    this.comboID,
    this.comboDetailsList,
    this.comboDiscountedPrice,
    this.comboStatus,
    this.comboTotalPrice,
    // this.terms_c,
  });

  Combo.fromJson(Map<String, dynamic> json) {
    comboID = json['id'];
    comboName = json['combo_name'];
    comboDetailsList = Combo.getComboEventDetails(json['array_of_evname']);
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

  static List<ComboDetails>? getComboEventDetails(List<dynamic>? json) {
    if (json == null || json == []) {
      return [];
    }
    log(json.toString());
    List<ComboDetails> l = [];
    for (var element in json) {
      ComboDetails comboDetails = ComboDetails(
          id: element['id'].toString(),
          name: element['name'],
          logo: element['logo']);
      l.add(comboDetails);
    }
    return l;
  }
}
