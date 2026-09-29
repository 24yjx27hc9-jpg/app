import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget{
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(
        minHeight: 30
      ),
      child: Column(
        spacing: 3,
        //тут будут дочерние виджеты с текстом
      ),
    );
  }
}