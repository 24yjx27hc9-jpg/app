import 'package:flutter/material.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';

class SettingInfoPage extends StatelessWidget{
  const SettingInfoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100, bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 3,
                  children: [
                    Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary,),
                    Text('Информация', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.primary))
                  ],
                ),
                Column(
                  children: [
                    Text('siski')
                  ],
                )
              ],
            ),
          ),
          BottomBar(),
          CustomAppBar(titleText: 'Информация', chapterText: 'Настройки')
        ],
      ),
    );
  }
}