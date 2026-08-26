import 'package:flutter/material.dart';
import 'package:flutter_notes/parser.dart';
import 'news_card.dart';

class NewsList extends StatefulWidget{
  const NewsList({super.key});

  @override
  State<StatefulWidget> createState() => _NewsList();
}

class _NewsList extends State<NewsList>{
  List<Map<String, String>> news = [];
  final parser = Parser(siteUrl: 'https://t67018w.sch.obrazovanie33.ru');

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  Future<void> loadNews() async {
    try {
      final value = await parser.fetchNewsList(
        'https://t67018w.sch.obrazovanie33.ru/news/?SHOWALL_1=1&SIZEN_1=20',
      );

      if (!mounted) return;

      setState(() {
        news = value;
      });
    } catch (e) {
      debugPrint('Ошибка загрузки новостей: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Лента новостей', style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFF4EABC7)),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];
          final imageUrl = item['image'];
          return NewsCard(
            heading: item['name'] ?? '',
            anonsText: item['anons_text'] ?? '',
            onTap: () {
              Navigator.pushNamed(context, '/news_page/page', arguments: item['url']);
            },
            image: imageUrl!.isEmpty
                ? const ColoredBox(
              color: Colors.grey,
              child: Icon(Icons.image_not_supported),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(
                  color: Colors.grey,
                  child: Icon(Icons.broken_image),
                  );
                },
              ),
            )
          );
        },
      )
    );
  }
}