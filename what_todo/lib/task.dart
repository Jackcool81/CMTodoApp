import 'package:firebase_database/firebase_database.dart';

class Task {
  final String? title;
  Task({
    required this.title,
  });

  Task.fromJson(Map<dynamic, dynamic> json)
      :title = json['title'] as String?;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }




}