import 'package:flutter/material.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';
import 'add_note_dialog.dart';

class NotesPage extends StatelessWidget{
  // Map<String, Map<String, dynamic>> notes = {};
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ПРОБНИК БОТТОМ БАРА', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
              IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => AddNoteDialog());
                },
                icon: Icon(Icons.add))
            ],
          ),
          BottomBar(),
          CustomAppBar(titleText: 'Заметки', chapterText: 'СОШ №9')
        ],
      ),
    );
  }
}