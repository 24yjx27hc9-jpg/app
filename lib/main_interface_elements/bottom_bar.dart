import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget{
  const BottomBar({super.key});

  Widget button(String iconName, String buttonName){
    IconData icon = Icons.question_mark;
    switch (iconName){
      case 'main':
        icon = Icons.home_rounded;
      case 'settings':
        icon = Icons.settings_sharp;
      case 'notes':
        icon = Icons.speaker_notes;
    }
    Widget button = Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        spacing: 1,
        children: [
          Icon(icon),
          Text(buttonName)
        ],
      ),
    );
    return button;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Theme.of(context).colorScheme.primary,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        spacing: 3,
        children: [
          button('main', 'Главная'),
          button('notes', 'Заметки'),
          button('settings', 'Настройки')
        ],
      ),
    );
  }
}