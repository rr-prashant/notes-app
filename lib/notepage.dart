import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/models/data_func.dart';
import 'package:notes_app/models/note.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Notepage extends StatefulWidget {
  Note note;
  bool isNew;

  Notepage({
    super.key,
    required this.note,
    required this.isNew,
  });

  @override
  State<Notepage> createState() => _NotepageState();
}

class _NotepageState extends State<Notepage> {
  QuillController _controller = QuillController.basic();
  @override

  // initializing the loading of the note
  void initState() {
    super.initState();
    loadexistingnote();
  }

  // to load existing notes' data

  void loadexistingnote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  // add the note
  void add() {
    int id = Provider.of<NoteData>(context, listen: false).getNotes().length;
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false)
        .addnote(Note(id: id, text: text));
  }

  // update the note
  void update() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updatenote(widget.note, text);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.grey[400],
          onPressed: () {
            if (widget.isNew && !_controller.document.isEmpty()) {
              add();
            } else {
              update();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // to use redo and undo the note content
          QuillToolbar.basic(
            controller: _controller,
            showAlignmentButtons: false,
            showBackgroundColorButton: false,
            showCenterAlignment: false,
            showColorButton: false,
            showCodeBlock: false,
            showDirection: false,
            showFontFamily: false,
            showDividers: false,
            showIndent: false,
            showHeaderStyle: false,
            showLink: false,
            showSearchButton: false,
            showInlineCode: false,
            showQuote: false,
            showListNumbers: false,
            showListBullets: false,
            showClearFormat: false,
            showBoldButton: false,
            showFontSize: false,
            showItalicButton: false,
            showUnderLineButton: false,
            showStrikeThrough: false,
            showListCheck: false,
            showSuperscript: false,
            showSubscript: false,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(25),
            child: QuillEditor.basic(
              // editor to write the content in the note
              controller: _controller,
              readOnly: false,
            ),
          ))
        ],
      ),
    );
  }
}
