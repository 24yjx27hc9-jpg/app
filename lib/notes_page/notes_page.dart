import 'package:flutter/material.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';
import 'add_note_dialog.dart';
import 'package:flutter_notes/database/database_class.dart';
import 'note_card.dart';

class NotesPage extends StatelessWidget{
  const NotesPage({super.key});

  Future<List> getNotes() async{
    final db = await DatabaseClass().database;
    final notes = await db.query('Notes');
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Center(child: CircularProgressIndicator()),
                BottomBar(),
                CustomAppBar(titleText: 'Заметки', chapterText: 'СОШ №9')
              ],
            ),
          );
        }
        final notes = snapshot.data ?? [];
        if (notes.isEmpty){
          final height = MediaQuery.of(context).size.height;
          Widget noneNotes = Center(
            child: SizedBox(
              height: height/3,
              child: Column(
                spacing: 2,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.question_mark, size: height/6,),
                  Text('Заметок пока нет...', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500, color: Colors.black)),
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        showDialog(context: context, builder: (context) => AddNoteDialog());
                      },
                      icon: Icon(Icons.add, color: Colors.white,)
                  )
                ],
              ),
            ),
          );
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                noneNotes,
                BottomBar(),
                CustomAppBar(titleText: 'Заметки', chapterText: 'СОШ №9')
              ],
            ),
          );
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: NoteCard(note: notes[index]),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 85),
                child: Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        showDialog(context: context, builder: (context) => AddNoteDialog());
                      },
                      icon: Icon(Icons.add, color: Colors.white,)
                  ),
                ),
              ),
              BottomBar(),
              CustomAppBar(titleText: 'Заметки', chapterText: 'СОШ №9')
            ],
          ),
        );
      },
    );
  }
}