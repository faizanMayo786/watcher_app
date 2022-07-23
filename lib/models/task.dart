
import 'dart:convert';

class Task {
  Task({
    required this.id,
    required this.title,
    required this.note,
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.isComplete,
    required this.color,
    required this.remind,
  });

  int id;
  String title;
  String note;
  String name;
  String date;
  String startTime;
  String endTime;
  String repeat;
  int isComplete;
  int color;
  int remind;

  factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        note: json["note"],
        name: json["name"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        repeat: json["repeat"],
        isComplete: json["isComplete"],
        color: json["color"],
        remind: json["remind"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "note": note,
        "name": name,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "repeat": repeat,
        "isComplete": isComplete,
        "color": color,
        "remind": remind,
      };
}
