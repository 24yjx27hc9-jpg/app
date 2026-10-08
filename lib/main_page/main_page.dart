import 'package:flutter/material.dart';
import 'button_menu.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'carousel.dart';

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
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 110), child: SizedBox(height: 280, child: Carousel(),)),
            ButtonMenu()
          ],
        ),
        BottomBar(),
        CustomAppBar(titleText: 'Главное меню', chapterText: 'СОШ №9')
      ],
    )
    );
  }
}