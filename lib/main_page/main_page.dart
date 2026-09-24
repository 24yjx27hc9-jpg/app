import 'package:flutter/material.dart';
import 'button_menu.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';
import 'director_words.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';

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
        BottomBar(),
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50), child: DirectorWords()),
            ButtonMenu()
          ],
        ),
        CustomAppBar(titleText: 'Главное меню', chapterText: 'СОШ №9')
      ],
    )
    );
  }
}