import 'package:flutter/material.dart';
import 'button_menu.dart';
import 'package:flutter_notes/custom_app_bar.dart';
import 'director_words.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
    extendBodyBehindAppBar: true,
    body: Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 60),
        child:
        ButtonMenu()),
        CustomAppBar(titleText: 'Главное меню', chapterText: 'СОШ №9')
      ],
    )
    );
  }
}