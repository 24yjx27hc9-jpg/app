import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget{
  final String errorCode;

  const ErrorHandler({super.key, required this.errorCode});

  Widget description(String errorCode, BuildContext context){
    final textErrorColor = Theme.of(context).colorScheme.onErrorContainer;
    switch(errorCode){
      case '403':
        return Text('Не удалось получить доступ к сайту школы:(\nЕсли у вас включен VPN - отключите его', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textErrorColor), textAlign: TextAlign.center,);
      case '500':
        return Text('На сайте школы произошла ошибка\n при отправке данных', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textErrorColor), textAlign: TextAlign.center,);
      default:
        return Text('Произошла ошибка при запросе\nна сайт школы', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textErrorColor), textAlign: TextAlign.center,);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onColor = Theme.of(context).colorScheme.errorContainer;
    final textErrorColor = Theme.of(context).colorScheme.onErrorContainer;
    return Container(
      height: 160,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.error),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
          colors: [
            onColor.withValues(alpha: 0.9),
            onColor.withValues(alpha: 0.85),
            onColor.withValues(alpha: 0.75),
            onColor.withValues(alpha: 0.55),
            onColor.withValues(alpha: 0.3),
            onColor.withValues(alpha: 0.1),
            onColor.withValues(alpha: 0.3),
            onColor.withValues(alpha: 0.55),
            onColor.withValues(alpha: 0.75),
            onColor.withValues(alpha: 0.85),
            onColor.withValues(alpha: 0.9),
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
            Padding(padding: EdgeInsets.only(top: 15), child: Icon(Icons.error_outline_rounded, color: textErrorColor, size: 50),),
            Text(errorCode, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: textErrorColor),),
            description(errorCode, context)
          ],
        ),
      )
    );
  }
}