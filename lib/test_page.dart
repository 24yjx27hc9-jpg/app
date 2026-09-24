import 'package:flutter/material.dart';
import 'main_interface_elements/custom_app_bar.dart';
import 'main_interface_elements/bottom_bar.dart';
import 'error_handler.dart';

class TestPage extends StatefulWidget{
  const TestPage({super.key});

  @override
  State<StatefulWidget> createState() => _TestPage();
}

class _TestPage extends State<TestPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BottomBar(),
          Padding(padding: EdgeInsets.only(top: 100), child: ErrorHandler(errorCode: '500')),
          Padding(padding: EdgeInsets.only(top: 300), child: ErrorHandler(errorCode: '403')),
          CustomAppBar(titleText: 'TEST PAGE', chapterText: 'BACK', onPrevious: () {Navigator.pushNamed(context, '/');})
        ],
      ),
    );
  }
}