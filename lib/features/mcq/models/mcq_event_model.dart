class MCQList {
  List<EventList> mcqEventList = [];

  MCQList();

  MCQList.fromJson(List result) {
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        mcqEventList.add(EventList.fromJson(result[i]));
      }
    }
  }
}

class EventList {
  String? id;
  FkEvent? fkEvent;
  bool? started;

  EventList({this.id, this.fkEvent, this.started});

  EventList.fromJson(var json) {
    id = json['id'];
    fkEvent =
        json['fk_event'] != null ? FkEvent.fromJson(json['fk_event']) : null;
    started = json['started'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (fkEvent != null) {
      data['fk_event'] = fkEvent!.toJson();
    }
    data['started'] = started;

    return data;
  }
}

class FkEvent {
  String? id;
  String? name;
  String? startTime;
  String? endTime;
  String? emsEventId;
  String? emsSlotId;

  FkEvent({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.emsEventId,
    this.emsSlotId,
  });

  FkEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    emsEventId = json['ems_event_id'];
    emsSlotId = json['ems_slot_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['ems_event_id'] = emsEventId;
    data['ems_slot_id'] = emsSlotId;

    return data;
  }
}
