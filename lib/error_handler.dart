import 'package:flutter/material.dart';

class ErrorHandler extends StatelessWidget{
  final String errorCode;

  const ErrorHandler({super.key, required this.errorCode});

  Widget description(String errorCode, BuildContext context){
    switch(errorCode){
      case '403':
        return Text('Не удалось получить доступ к сайту школы:(', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black), textAlign: TextAlign.center,);
      case '500':
        return Text('На сайте школы произошла ошибка при отправке данных', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black), textAlign: TextAlign.center,);
      default:
        return Text('Произошла ошибка при запросе на сайт школы', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black), textAlign: TextAlign.center,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: Column(
        children: [
          Text(errorCode, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black)),
          description(errorCode, context)
        ],
      ),
    );
  }
}