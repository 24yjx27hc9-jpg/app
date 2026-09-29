import 'package:flutter/material.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(child: Text('ТУТ ПОКА НИЧЕГО НЕТ:(', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black))),
          BottomBar(),
          CustomAppBar(titleText: 'Настройки', chapterText: 'СОШ №9')
        ],
      ),
    );
  }
}