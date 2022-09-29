class Events {
  List<EventData> eventData;

  Events({this.eventData});

  Events.fromJson(Map<String, dynamic> json) {
    if (json['event_data'] != null) {
      eventData = <EventData>[];
      json['event_data'].forEach((v) {
        eventData.add(new EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventData != null) {
      data['event_data'] = this.eventData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventData {
  String eventId;
  String eventTitle;
  String description;
  String eventImage;
  String eventImageRName;
  String eventAuthor;
  String isActive;
  String createdAt;
  String modifiedAt;

  EventData(
      {this.eventId,
      this.eventTitle,
      this.description,
      this.eventImage,
      this.eventImageRName,
      this.eventAuthor,
      this.isActive,
      this.createdAt,
      this.modifiedAt});

  EventData.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventTitle = json['event_title'];
    description = json['description'];
    eventImage = json['event_image'];
    eventImageRName = json['event_image_r_name'];
    eventAuthor = json['event_author'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_title'] = this.eventTitle;
    data['description'] = this.description;
    data['event_image'] = this.eventImage;
    data['event_image_r_name'] = this.eventImageRName;
    data['event_author'] = this.eventAuthor;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['modified_at'] = this.modifiedAt;
    return data;
  }
}