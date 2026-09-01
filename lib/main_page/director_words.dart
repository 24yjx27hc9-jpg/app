import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_notes/parser.dart';

class DirectorWords extends StatefulWidget{
  const DirectorWords({super.key});

  @override
  State<StatefulWidget> createState() => _DirectorWords();
}

class _DirectorWords extends State<DirectorWords>{
  final parser = Parser(siteUrl: 'https://t67018w.sch.obrazovanie33.ru');
  Map<String, dynamic> elements = {};
  bool isFullOpen = false;
  
  @override
  void initState() {
    super.initState();
    loadWords();
  }
  
  Future<void> loadWords() async{
    try{
      final value = await parser.getDirectorWords();
      if (!mounted) return;
      setState(() {
        elements = value;
      });
    }
    catch(e){
      debugPrint('Ошибка загрузки новостей: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if(elements.isEmpty){
      return CircularProgressIndicator();
    }
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                'О школе',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: Colors.blueGrey),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(elements['heading'], style: Theme.of(context).textTheme.titleMedium, maxLines: 3),
                          Html(data: elements['text'],
                            style: {'*' : Style(color: Colors.white)},
                            onLinkTap: (url, element, attributes) async{
                              if (url?.startsWith('http') ?? false){
                                await launchUrl( Uri.parse(url!),
                                    mode: LaunchMode.externalApplication );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Align(
                        alignment: AlignmentGeometry.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            elements['image_URL'],
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}