class BookedSlotModel {
  String? ticket_id,
      created_at,
      updated_at,
      start_time,
      end_time,
      year,
      mode,
      certificate_url;
  int? id, fk_event, fk_user, fk_slot, capacity;

  BookedSlotModel(
      {this.ticket_id,
      this.created_at,
      this.updated_at,
      this.start_time,
      this.end_time,
      this.year,
      this.certificate_url,
      this.id,
      this.fk_event,
      this.fk_user,
      this.fk_slot,
      this.capacity,
      this.mode});

  BookedSlotModel.fromJson(Map<String, dynamic> data) {
    ticket_id = data["ticket_id"];
    created_at = data["created_at"];
    updated_at = data["updated_at"];
    start_time = data["start_time"];
    end_time = data["end_time"];
    year = data["year"];
    certificate_url = data["certificate_url"];
    id = data["id"];
    fk_event = data["fk_event"];
    fk_user = data["fk_user"];
    fk_slot = data["fk_slot"];
    capacity = data["capacity"];
    mode = data["mode"];
  }
}
