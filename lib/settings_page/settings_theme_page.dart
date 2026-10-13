import 'package:flutter/material.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';

class SettingsThemePage extends StatefulWidget{
  const SettingsThemePage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsThemePage();
}

class _SettingsThemePage extends State<SettingsThemePage>{
  Widget mainColorTheme(Color color){
    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      color: Theme.of(context).colorScheme.tertiary
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      color: Theme.of(context).colorScheme.primary
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 110),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mainColorTheme(Colors.black87),
                mainColorTheme(Colors.white)
              ],
            ),
          ),
          BottomBar(),
          CustomAppBar(titleText: 'Темы', chapterText: 'Настройки')
        ],
      ),
    );
  }
}