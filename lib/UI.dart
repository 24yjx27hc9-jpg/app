import 'package:flutter/material.dart';
import 'package:flutter_notes/news_page/news_list.dart';
import 'news_page//news_page.dart';
import 'main_page/main_page.dart';
import 'contacts_page/contacts_page.dart';
import 'theme/theme.dart';
import 'test_page.dart';
import 'notes_page/notes_page.dart';
import 'settings_page/settings_page.dart';

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => const  MainPage(),
        '/news_page' : (context) => const NewsList(),
        '/news_page/page' : (context) => const NewsPage(),
        '/contacts' : (context) => const ContactsPage(),
        '/test' : (context) => const TestPage(),
        '/notes' : (context) => const NotesPage(),
        '/settings' : (context) => const SettingsPage()
      },
      theme: AppTheme.light,
    );
  }
}