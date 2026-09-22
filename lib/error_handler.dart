import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget{
  final String errorCode;

  const ErrorHandler({super.key, required this.errorCode});

  Widget description(String errorCode, BuildContext context){
    switch(errorCode){
      case '403':
        return Text('Не удалось получить доступ к сайту школы:(\nЕсли у вас включен VPN - отключите его', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.red), textAlign: TextAlign.center,);
      case '500':
        return Text('На сайте школы произошла ошибка при отправке данных', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.red), textAlign: TextAlign.center,);
      default:
        return Text('Произошла ошибка при запросе\nна сайт школы', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.red), textAlign: TextAlign.center,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
          colors: [
            Colors.redAccent.withValues(alpha: 0.5),
            Colors.redAccent.withValues(alpha: 0.45),
            Colors.redAccent.withValues(alpha: 0.35),
            Colors.redAccent.withValues(alpha: 0.25),
            Colors.redAccent.withValues(alpha: 0.1),
            Colors.redAccent.withValues(alpha: 0.05),
            Colors.redAccent.withValues(alpha: 0.1),
            Colors.redAccent.withValues(alpha: 0.25),
            Colors.redAccent.withValues(alpha: 0.35),
            Colors.redAccent.withValues(alpha: 0.45),
            Colors.redAccent.withValues(alpha: 0.5),
          ],
          stops: [
            0,
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.8,
            0.9,
            1
          ]
        )
      ),
      child:
      Align(
        alignment: Alignment.center,
        child: Column(
          spacing: 2,
          children: [
            Padding(padding: EdgeInsets.only(top: 15), child: Icon(Icons.error_outline_rounded, color: Colors.red, size: 50),),
            Text(errorCode, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.red),),
            description(errorCode, context)
          ],
        ),
      )
    );
  }
}