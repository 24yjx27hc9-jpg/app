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
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        spacing: 1,
        children: [
          Icon(icon, color: Colors.white,),
          Text(buttonName, style: TextStyle(color: Colors.white, fontSize: 9),)
        ],
      ),
    );
    return button;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child:  Container(
        height: 60,
        width: 210,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primary
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            spacing: 3,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button('notes', 'Заметки'),
              button('main', 'Главная'),
              button('settings', 'Настройки')
            ],
          ),
        )
      ),
    );
  }
}