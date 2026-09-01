import 'package:flutter/material.dart';

class ButtonMenu extends StatefulWidget{
  const ButtonMenu({super.key});

  @override
  State<StatefulWidget> createState() => _ButtonMenu();
}

class _ButtonMenu extends State<ButtonMenu>{
  final buttonsInfo = [
    ['Новости', '/news_page'],
    ['Контакты', '/contacts']
  ];

  Widget button(int index){
    Widget? icon;
    switch(buttonsInfo[index][1]){
      case '/news_page':
        icon = Icon(Icons.newspaper_rounded);
      case '/contacts':
        icon = Icon(Icons.call);
    }
    return Padding(
          padding: EdgeInsetsGeometry.all(3),
          child: TextButton(
              style: TextButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF4EABC7),

                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, buttonsInfo[index][1]);
              },
              child: Align(
                  alignment: AlignmentGeometry.center,
                  child: Row(
                      spacing: 2,
                      children: [
                        icon!,
                        Text(buttonsInfo[index][0], textDirection: TextDirection.ltr, textAlign: TextAlign.center)
                      ]
                  )
              )
          )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Align(
              alignment: AlignmentGeometry.bottomLeft,
              child: Text(
                'Информация',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: buttonsInfo.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 70),
              itemBuilder: (context, index) {
                return button(index);
              }
          )
        ],
      ),
    );
  }
}