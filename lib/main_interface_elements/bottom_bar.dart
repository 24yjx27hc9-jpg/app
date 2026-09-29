import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget{
  static String isSelected = 'Главная';
  const BottomBar({super.key});

  void selectedPage(BuildContext context){
    final page = ModalRoute.of(context)?.settings.name;
    switch(page){
      case '/settings':
        isSelected = 'Настройки';
      case '/notes':
        isSelected = 'Заметки';
      default:
        isSelected = 'Главная';
    }
  }

Widget buttonIcon(String buttonName){
    Widget? icon;
    switch(buttonName){
      case 'Главная':
        icon = Icon(Icons.home_rounded, color: Colors.white);
      case 'Настройки':
        icon = Icon(Icons.settings_sharp, color: Colors.white);
      case 'Заметки':
        icon = Icon(Icons.speaker_notes, color: Colors.white);
      default:
        icon = Icon(Icons.question_mark, color: Colors.white);
    }
    return icon;
  }

  Widget button(String buttonName, String pushName, BuildContext context){
    Widget icon = buttonIcon(buttonName);
    Widget button = Container(
      height: 70,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: isSelected == buttonName ? Colors.white.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 1,
        children: [
          icon,
          Text(buttonName, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600))
        ],
      ),
    );
    if (isSelected != buttonName){
      button = GestureDetector(
        onTap: () => Navigator.pushNamed(context, pushName),
        child: button,
      );
      return button;
    }
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
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).colorScheme.primary
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                spacing: 3,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button('Заметки', '/notes', context),
                  button('Главная', '/', context),
                  button('Настройки', '/settings', context)
                ],
              ),
            )
        ),
      ),
    );
  }
}