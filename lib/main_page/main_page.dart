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
    appBar: AppBar(backgroundColor: Color(0xFF4EABC7), title: const Text('Главное меню', textDirection: TextDirection.ltr, style: TextStyle(color: Colors.white))),
    body: ButtonMenu()
    );
  }
}