import 'package:flutter/material.dart';
import 'package:flutter_notes/parser.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage>{
  Map<String, String> logo = {};
  Parser parser = Parser(siteUrl: 'https://t67018w.sch.obrazovanie33.ru');

  @override
  void initState() {
    loadLogo();
    super.initState();
  }

  Future<void> loadLogo() async{
    try{
      final value = await parser.getSchoolLogo();
      if (!mounted) return;
      setState(() {
        logo = value;
      });
    }
    catch(e){
      debugPrint('Ошибка загрузки лого : $e');
    }
  }

  Widget schoolLogo() {
    return Container(
      alignment: AlignmentGeometry.center,
      height: MediaQuery.of(context).size.height/6,
      width: MediaQuery.of(context).size.width/3,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 3,
            offset: Offset(0,0)
          )
        ]
      ),
      padding: EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(logo['URL']!)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(logo.isEmpty){
      return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Center(child: CircularProgressIndicator(),),
            BottomBar(),
            CustomAppBar(titleText: 'Настройки', chapterText: 'СОШ №9')
          ],
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(100),
            child: SizedBox(
              height: MediaQuery.of(context).size.height/4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  schoolLogo(),
                  Text('МБОУ СОШ 9', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black))
                ],
              ),
            )
          ),
          BottomBar(),
          CustomAppBar(titleText: 'Настройки', chapterText: 'СОШ №9')
        ],
      ),
    );
  }
}