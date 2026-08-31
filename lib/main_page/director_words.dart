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
  
  @override
  void initState() {
    super.initState();
    loadWords();
  }
  
  Future<void> loadWords() async{
    final value = await parser.getDirectorWords();
    setState(() async {
      elements = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey
      ),
      child: Row(
        spacing: 10,
        children: [
          Column(
            children: [
              Text(elements['heading'], style: Theme.of(context).textTheme.titleLarge),
              Html(
                data: elements['text'],
                onLinkTap: (url, element, attributes) async{
                  if (url?.startsWith('http') ?? false){
                    await launchUrl(
                        Uri.parse(url!),
                        mode: LaunchMode.externalApplication
                    );
                  }
                },
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(elements['image_URL']),
          )
        ],
      ),
    );
  }
}