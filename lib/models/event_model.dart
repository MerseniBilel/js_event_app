// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  Event({
    required this.eventLeader,
    required this.id,
    required this.name,
    required this.description,
    required this.eventimg,
    required this.goingMembers,
    required this.eventdate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  EventLeader eventLeader;
  String id;
  String name;
  String description;
  String eventimg;
  int goingMembers;
  DateTime eventdate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventLeader: EventLeader.fromJson(json["eventLeader"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        eventimg: json["eventimg"],
        goingMembers: json["goingMembers"],
        eventdate: DateTime.parse(json["eventdate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "eventLeader": eventLeader.toJson(),
        "_id": id,
        "name": name,
        "description": description,
        "eventimg": eventimg,
        "goingMembers": goingMembers,
        "eventdate": eventdate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class EventLeader {
  EventLeader({
    required this.leaderName,
    required this.leaderLastname,
    required this.leaderimg,
  });

  String leaderName;
  String leaderLastname;
  String leaderimg;

  factory EventLeader.fromJson(Map<String, dynamic> json) => EventLeader(
        leaderName: json["leaderName"],
        leaderLastname: json["leaderLastname"],
        leaderimg: json["leaderimg"],
      );

  Map<String, dynamic> toJson() => {
        "leaderName": leaderName,
        "leaderLastname": leaderLastname,
        "leaderimg": leaderimg,
      };
}
