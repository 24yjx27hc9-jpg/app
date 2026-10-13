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
        boxShadow: [BoxShadow(
          color: Theme.of(context).colorScheme.secondaryContainer,
          offset: Offset(0, 0),
          spreadRadius: 0.5,
          blurRadius: 10
        )],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(logo['URL']!)
      ),
    );
  }

  Widget button(String name, IconData icon, String namePage, BuildContext context){
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, namePage),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.outline)
        ),
        margin: EdgeInsets.all(5),
        child: Row(
          spacing: 2,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer,),
            Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer))
          ],
        ),
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
            padding: EdgeInsets.only(top: 100, bottom: 80),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/4,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      schoolLogo(),
                      Text('МБОУ СОШ 9', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      button('Информация', Icons.info_outline, '/settings/info', context),
                      button('Темы', Icons.color_lens_outlined, '/settings/theme', context)
                    ],
                  ),
                )
              ],
            )
          ),
          BottomBar(),
          CustomAppBar(titleText: 'Настройки', chapterText: 'СОШ №9')
        ],
      ),
    );
  }
}