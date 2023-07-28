import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/data_func.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/notepage.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initNotes();
  }

  void newnote() {
    int id = Provider.of<NoteData>(context, listen: false).getNotes().length;

    Note Nnote = Note(
      id: id,
      text: '',
    );

    navNote(Nnote, true);
  }

  void navNote(Note note, bool isNew) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Notepage(
            note: note,
            isNew: isNew,
          ),
        ));
  }

  void delete(Note note) {
    Provider.of<NoteData>(context, listen: false).delete(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: CupertinoColors.systemGroupedBackground,
              floatingActionButton: FloatingActionButton(
                onPressed: newnote,
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 143, 143, 143),
                child: const Icon(
                  Icons.note_alt_outlined,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25, top: 75),
                    child: Text(
                      'Notes',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // if there are no notes this condition is applied else notes are displayed
                  value.getNotes().length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                              child: Text(
                            "No Notes",
                            style: TextStyle(color: Colors.grey[400]),
                          )),
                        )
                      : CupertinoListSection.insetGrouped(
                          children: List.generate(
                              value.getNotes().length,
                              (index) => CupertinoListTile(
                                    title: Text(value.getNotes()[index].text),
                                    onTap: () =>
                                        navNote(value.getNotes()[index], false),
                                    trailing: IconButton(
                                        onPressed: () =>
                                            delete(value.getNotes()[index]),
                                        icon: const Icon(Icons.delete)),
                                  )))
                ],
              ),
            ));
  }
}
