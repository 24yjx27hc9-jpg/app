import 'package:flutter/material.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';

class SettingsThemePage extends StatefulWidget{
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  const SettingsThemePage({super.key, required this.onThemeChanged, required this.themeMode});

  @override
  State<SettingsThemePage> createState() => _SettingsThemePage();
}

class _SettingsThemePage extends State<SettingsThemePage>{
  Widget mainColorTheme(Color color, bool selected, String nameTheme, ThemeMode themeMode){
    return GestureDetector(
      onTap: () {
        widget.onThemeChanged(themeMode);
      },
      child: Column(
        spacing: 5,
        children: [
          Container(
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
                    height: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
                              color: Theme.of(context).colorScheme.tertiary
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.primary
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, right: 25, left: 25),
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(nameTheme, style: Theme.of(context).textTheme.bodyMedium),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
            ),
            child: selected
                ? Icon(
              Icons.check,
              size: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            )
                : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final systemColor = brightness == Brightness.dark
        ? Colors.black87
        : Colors.white;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 110),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mainColorTheme(Colors.black87, widget.themeMode == ThemeMode.dark, 'Темная', ThemeMode.dark),
                    mainColorTheme(Colors.white, widget.themeMode == ThemeMode.light, 'Светлая', ThemeMode.light)
                  ],
                ),
                mainColorTheme(systemColor, widget.themeMode == ThemeMode.system, 'Системная', ThemeMode.system)
              ],
            )
          ),
          BottomBar(),
          CustomAppBar(titleText: 'Темы', chapterText: 'Настройки')
        ],
      ),
    );
  }
}