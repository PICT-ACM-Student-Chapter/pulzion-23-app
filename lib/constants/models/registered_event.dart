class RegisteredEvent {
  int? id;
  String? transactionId;
  int? amount;
  DateTime? createdAt;
  List<dynamic>? events;
  List<dynamic>? combos;
  String? status;

  RegisteredEvent({
    this.id,
    this.transactionId,
    this.amount,
    this.createdAt,
    this.events,
    this.status,
    this.combos,
  });

  RegisteredEvent.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    transactionId = json["transaction_id"];
    amount = json["amount"];
    createdAt = DateTime.parse(json["created_at"]);
    events = json["events"];
    combos = json["combo"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["transaction_id"] = transactionId;
    data["amount"] = amount;
    data["created_at"] = createdAt!.toIso8601String();
    data["events"] = events;
    data["combos"] = combos;
    data["status"] = status;

    return data;
  }
}
