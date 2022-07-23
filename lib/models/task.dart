
import 'dart:convert';

class Task {
  Task({
    this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.isCompleted,
    required this.color,
    required this.remind,
  });

  int? id;
  String title;
  String note;
  String date;
  String startTime;
  String endTime;
  String repeat;
  int isCompleted;
  int color;
  int remind;

  factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"].toString(),
        note: json["note"].toString(),
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        repeat: json["repeat"],
        isCompleted: json["isCompleted"],
        color: json["color"],
        remind: json["remind"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "note": note,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "repeat": repeat,
        "isCompleted": isCompleted,
        "color": color,
        "remind": remind,
      };
}
