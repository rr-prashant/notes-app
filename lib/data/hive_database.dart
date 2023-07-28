import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/note.dart';

class HiveData {
  // loading hive
  final _myBox = Hive.box('notes');

  // loading notes from hive
  List<Note> load() {
    List<Note> savedFormat = [];

    if (_myBox.containsKey("all")) {
      List<dynamic> save = _myBox.get("all");
      for (int i = 0; i < save.length; i++) {
        Note seperateNote = Note(id: save[i][0], text: save[i][1]);

        savedFormat.add(seperateNote);
      }
    } else {
      savedFormat.add(Note(id: 0, text: 'First Note'));
    }
    return savedFormat;
  }

  // save notes from hive
  void save(List<Note> all) {
    List<List<dynamic>> allnote = [];
    for (var note in all) {
      int id = note.id;
      String text = note.text;
      allnote.add([id, text]);
    }
    _myBox.put("all", allnote);
  }
}
