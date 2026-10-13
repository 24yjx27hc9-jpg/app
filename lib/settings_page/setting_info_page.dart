import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';

class SettingInfoPage extends StatelessWidget{
  const SettingInfoPage({super.key});
  
  Widget urlText(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      spacing: 3,
      children: [
        Text('Ссылка на репозиторий Github:', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black)),
        Expanded(
          child: GestureDetector(
            onTap: () async{
              await launchUrl(
                  Uri.parse('https://github.com/24yjx27hc9-jpg/app'),
                  mode: LaunchMode.externalApplication
              );
            },
            child: Text('https://github.com/24yjx27hc9-jpg/app', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue), maxLines: 3,),
          ),
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 110, bottom: 80, right: 10, left: 10),
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    urlText(context),
                    Text('Версия: 0.0.1', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),),
                    Text('Актуальная версия: 0.0.1', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),),
                    Text('Средства разработки: Dart (язык программирования), Flutter (фреймворк)', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),)
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