import 'package:flutter/material.dart';
import 'package:flutter_notes/news_page/news_list.dart';
import 'news_page//news_page.dart';
import 'main_page/main_page.dart';
import 'contacts_page/contacts_page.dart';
import 'theme/theme.dart';
import 'test_page.dart';
import 'notes_page/notes_page.dart';
import 'settings_page/settings_page.dart';
import 'notes_page/note_page.dart';
import 'settings_page/setting_info_page.dart';
import 'settings_page/settings_theme_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp>{
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    loadTheme();
    super.initState();
  }

  Future<void> loadTheme() async{
    final prefs = await SharedPreferences.getInstance();
    final themePrefs = prefs.getString('themeMode');
    if (themePrefs == null) return;
    setState(() {
      switch(themePrefs){
        case 'light':
          themeMode = ThemeMode.light;
        case 'dark':
          themeMode = ThemeMode.dark;
        case 'system':
          themeMode = ThemeMode.system;
      }
    });
  }

  Future<void> changeTheme(ThemeMode mode) async{
    final prefs = await SharedPreferences.getInstance();
    String themeName;
    switch(mode){
      case ThemeMode.system:
        themeName = 'system';
      case ThemeMode.light:
        themeName = 'light';
      case ThemeMode.dark:
        themeName = 'dark';
    }
    prefs.setString('themeMode', themeName);
    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => const MainPage(),
        '/news_page' : (context) => const NewsList(),
        '/news_page/page' : (context) => const NewsPage(),
        '/contacts' : (context) => const ContactsPage(),
        '/test' : (context) => const TestPage(),
        '/notes' : (context) => const NotesPage(),
        '/notes/page' : (context) => const NotePage(),
        '/settings' : (context) => const SettingsPage(),
        '/settings/info' : (context) => const SettingInfoPage(),
        '/settings/theme' : (context) => SettingsThemePage(
          themeMode: themeMode,
          onThemeChanged: changeTheme,
        )
      },
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
    );
  }
}