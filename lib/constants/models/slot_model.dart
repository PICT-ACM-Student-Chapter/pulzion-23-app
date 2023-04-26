class Slot {
  String? start_time, end_time, created_at, updated_at, year;
  int? id, capacity, fk_event;

  Slot({
    this.capacity,
    this.created_at,
    this.end_time,
    this.fk_event,
    this.id,
    this.start_time,
    this.updated_at,
    this.year,
  });

  Slot.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    start_time = data['start_time'];
    end_time = data['end_time'];
    capacity = data['capacity'];
    year = data['year'];
    created_at = data['created_at'];
    updated_at = data['updated_at'];
    fk_event = data['fk_event'];
  }
}

class EventSlot {
  List<Slot>? slots;

  EventSlot({this.slots});

  EventSlot.fromJson(Map<String, dynamic> data) {
    slots = data['slots'] == null
        ? null
        : (data['slots'] as List).map((e) => Slot.fromJson(e)).toList();
  }
}
