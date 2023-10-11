import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';
import 'package:note_bucket/src/res/assets.dart';

import 'package:note_bucket/src/res/model/note.dart';
import 'package:note_bucket/src/res/services/local_bd.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key, this.note});

  final Note? note;

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final localDb = LocalDBService();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    super.dispose();

    log(_titleController.text);
    log(_descriptionController.text);

    final title = _titleController.text;
    final desc = _descriptionController.text;

    if (widget.note != null) {
      if (title.isEmpty && desc.isEmpty) {
        localDb.deleteNode(id: widget.note!.id);
      } else if (widget.note!.title != title ||
          widget.note!.description != desc) {
        final newNote = widget.note!.copyWith(
          title: title,
          description: desc,
        );
        localDb.saveNote(note: newNote);
      }
    } else {
      final newNote = Note(
          id: Isar.autoIncrement,
          title: title,
          description: desc,
          lastmod: DateTime.now());
      localDb.saveNote(note: newNote);
    }

    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              widget.note != null
                  ? Padding(
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Color.fromARGB(235, 246, 6, 6),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    " Delete Note ?",
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset(AnimationAssets.delete),
                                      Text(
                                        " This will be permanently deleted.",
                                        style: TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          localDb.deleteNode(
                                              id: widget.note!.id);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Proceed")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"))
                                  ],
                                );
                              });
                        },
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Title"),
              style: GoogleFonts.poppins(
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              maxLines: 13,
              controller: _descriptionController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Description"),
              style: GoogleFonts.poppins(
                fontSize: 20,
              ),
            ),
          )
        ],
      )),
    );
  }
}
