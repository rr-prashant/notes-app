import 'package:flutter/material.dart';
import 'package:notes_app/data/hive_database.dart';
import 'package:notes_app/models/note.dart';

class NoteData extends ChangeNotifier {
  // linking hive database of the notes
  final db = HiveData();

  List<Note> all = [];

  // initializing note i.e. loading all notes from temp database into all
  void initNotes() {
    all = db.load();
  }

  // returns all the notes
  List<Note> getNotes() {
    return all;
  }

  // adding new node and saing in database
  void addnote(Note note) {
    all.add(note);
    db.save(all);
    notifyListeners(); // notifies system when a note is added
  }

  // updates a existing note after filtering out and matching the exact id of the existing note
  void updatenote(Note note, String text) {
    for (int i = 0; i < all.length; i++) {
      if (all[i].id == note.id) {
        all[i].text = text;
        db.save(all);
        notifyListeners();
      }
    }
  }

  //deletes notes
  void delete(Note note) {
    all.remove(note);
    db.save(all);
    notifyListeners();
  }
}
