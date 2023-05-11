import 'dart:convert';

import 'package:overthink/model/NotesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesProvider {
  static const String kNotesKey = 'notes';

  // Save a list of notes to local storage
  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = notes.map((note) => note.toMap()).toList();
    await prefs.setString(kNotesKey, jsonEncode(notesData));
  }

  // Retrieve a list of notes from local storage
  static Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getString(kNotesKey);
    if (notesData != null) {
      final notesJson = jsonDecode(notesData) as List<dynamic>;
      return notesJson.map((noteJson) => Note.fromMap(noteJson)).toList();
    }
    return [];
  }
}
