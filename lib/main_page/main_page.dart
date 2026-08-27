import 'package:flutter/material.dart';
import 'button_menu.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(title: const Text('Главное меню', textDirection: TextDirection.ltr)),
    body: ButtonMenu()
    );
  }
}