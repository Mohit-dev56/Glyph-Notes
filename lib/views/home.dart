import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:note_bucket/src/res/model/note.dart';
import 'package:note_bucket/src/res/services/local_bd.dart';
import 'package:note_bucket/src/res/strings.dart';
import 'package:note_bucket/views/widgets/create_note.dart';
import 'package:note_bucket/views/widgets/empty_view.dart';
import 'package:note_bucket/views/widgets/note_list.dart';
import 'package:note_bucket/views/widgets/note_list_item.dart';
import 'package:note_bucket/views/widgets/notes_grid.dart';

import '../src/res/assets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isListView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(AppStrings.appName,
                      style: TextStyle(
                        fontSize: 29,
                        fontFamily: "Nothing",
                      )),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isListView = !isListView;
                      });
                    },
                    icon: Icon(
                      isListView ? Icons.splitscreen_outlined : Icons.grid_view,
                    ),
                  ),
                ],
              ),
            ),
            //const EmptyView(),
            Expanded(
              child: StreamBuilder<List<Note>>(
                  stream: LocalDBService().listenAllNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const EmptyView();
                    }
                    final notes = snapshot.data!;
                    // if (isListView) {
                    //   return NotesList(notes: notes);
                    // }
                    // return NotesGrid(notes: notes);

                    return AnimatedSwitcher(
                      duration: Duration(
                        milliseconds: 400,
                      ),
                      child: isListView
                          ? NotesList(notes: notes)
                          : NotesGrid(notes: notes),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(248, 10, 10, 0.864),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateNoteView()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
