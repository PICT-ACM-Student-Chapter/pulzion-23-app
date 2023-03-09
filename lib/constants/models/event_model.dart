class EventList {
  List<Events>? events;

  EventList({this.events});

  EventList.fromJson(Map<String, dynamic> json) {
    events = json["events"] == null
        ? null
        : (json["events"] as List).map((e) => Events.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data["events"] = events?.map((e) => e.toJson()).toList();
    }

    return data;
  }
}

class Events {
  int? id;
  String? name;
  String? description;
  String? type;
  String? mode;
  bool? isActive;
  bool? play;
  int? price;
  String? link;
  String? tagline;
  String? logo;
  String? rules;
  String? rounds;
  String? teams;
  String? notes;
  String? createdAt;
  String? updatedAt;

  Events({
    this.id,
    this.name,
    this.description,
    this.type,
    this.mode,
    this.isActive,
    this.play,
    this.price,
    this.link,
    this.tagline,
    this.logo,
    this.rules,
    this.rounds,
    this.teams,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  Events.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    type = json["type"];
    mode = json["mode"];
    isActive = json["is_active"];
    play = json["play"];
    price = json["price"];
    link = json["link"];
    tagline = json["tagline"];
    logo = json["logo"];
    rules = json["rules"];
    rounds = json["rounds"];
    teams = json["teams"];
    notes = json["notes"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["type"] = type;
    data["mode"] = mode;
    data["is_active"] = isActive;
    data["play"] = play;
    data["price"] = price;
    data["link"] = link;
    data["tagline"] = tagline;
    data["logo"] = logo;
    data["rules"] = rules;
    data["rounds"] = rounds;
    data["teams"] = teams;
    data["notes"] = notes;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;

    return data;
  }
}
