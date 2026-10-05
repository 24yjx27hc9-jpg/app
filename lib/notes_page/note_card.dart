import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget{
  final Map<String, dynamic> note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    Widget text = Text('У заметки нет текста', style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, color: Colors.black), overflow: TextOverflow.ellipsis,);
    if (note['text'] != null){
      text = Text(note['text'].toString(), style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, color: Colors.black), overflow: TextOverflow.ellipsis,);
    }
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/notes/page', arguments: note['id']),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10)
        ),
        constraints: BoxConstraints(
          minHeight: 30,
        ),
        child: Column(
          spacing: 3,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note['title'].toString(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black)),
            text
          ],
        ),
      ),
    );
  }
}