import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget{
  final Map<String, Object> note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    Widget text = Text('У заметки нет текста', style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, color: Colors.black),);
    if (note['text'] != null){
      text = Text(note['text'].toString(), style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500, color: Colors.black));
    }
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(10)
      ),
      constraints: BoxConstraints(
        minHeight: 30
      ),
      child: Column(
        spacing: 3,
        children: [
          Text(note['title'].toString(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black)),
          text
        ],
      ),
    );
  }
}