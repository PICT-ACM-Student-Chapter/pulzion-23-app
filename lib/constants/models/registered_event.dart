class RegisteredEvent {
  int? id;
  String? transactionId;
  int? amount;
  DateTime? createdAt;
  List<dynamic>? events;
  String? status;

  RegisteredEvent({
    this.id,
    this.transactionId,
    this.amount,
    this.createdAt,
    this.events,
    this.status,
  });

  RegisteredEvent.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    transactionId = json["transaction_id"];
    amount = json["amount"];
    createdAt = DateTime.parse(json["created_at"]);
    events = json["events"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["transaction_id"] = transactionId;
    data["amount"] = amount;
    data["created_at"] = createdAt!.toIso8601String();
    data["events"] = events;
    data["status"] = status;

    return data;
  }
}
