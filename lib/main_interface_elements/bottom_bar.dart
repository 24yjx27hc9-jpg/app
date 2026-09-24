import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget{
  static String isSelected = 'main';
  const BottomBar({super.key});

  void selectedPage(BuildContext context){
    final page = ModalRoute.of(context)?.settings.name;
    switch(page){
      case '/settings':
        isSelected = 'settings';
      case '/notes':
        isSelected = '/notes';
      default:
        isSelected = 'main';
    }
  }

  Widget buttonIcon(String buttonName){
    Widget? icon;
    switch(buttonName){
      case 'main':
        icon = Icon(Icons.home_rounded, color: Colors.white);
      case 'settings':
        icon = Icon(Icons.settings_sharp, color: Colors.white);
      case 'notes':
        icon = Icon(Icons.speaker_notes, color: Colors.white);
      default:
        icon = Icon(Icons.question_mark, color: Colors.white);
    }
    return icon;
  }

  Widget button(String buttonName){
    Widget icon = buttonIcon(buttonName);
    Widget button = Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isSelected == buttonName ? Colors.white.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 1,
        children: [
          icon,
          Text(buttonName, style: TextStyle(color: Colors.white, fontSize: 12),)
        ],
      ),
    );
    return button;
  }

  @override
  Widget build(BuildContext context) {
    selectedPage(context);
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child:  Container(
            height: 70,
            width: 240,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                spacing: 3,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button('notes'),
                  button('main'),
                  button('settings')
                ],
              ),
            )
        ),
      ),
    );
  }
}