import 'package:flutter/material.dart';

import '../../src/res/model/note.dart';
import 'note_list_item.dart';
import 'package:auto_animated_list/auto_animated_list.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return AutoAnimatedList<Note>(
        padding: EdgeInsets.all(20),
        items: notes,
        itemBuilder: (context, note, index, animation) {
          return SizeFadeTransition(
              animation: animation, child: NoteListItem(note: notes[index]));
        });
  }
}
