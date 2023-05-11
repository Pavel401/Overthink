import 'package:flutter/material.dart';

class Note {
  String title;
  String note1;
  String note2;
  String note3;
  String note4;
  DateTime time;

  Note({
    required this.title,
    required this.note1,
    required this.note2,
    required this.note3,
    required this.note4,
    required this.time,
  });

  // Convert Note object to a map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'note1': note1,
      'note2': note2,
      'note3': note3,
      'note4': note4,
      'time': time
          .millisecondsSinceEpoch, // Convert DateTime to milliseconds for storage
    };
  }

  // Create a Note object from a map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      note1: map['note1'],
      note2: map['note2'],
      note3: map['note3'],
      note4: map['note4'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }
}
