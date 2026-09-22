import 'package:flutter/material.dart';
import 'package:flutter_notes/parser.dart';
import 'news_card.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';
import 'package:flutter_notes/error_handler.dart';

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

  Widget newsCardGen(Map<String, String> item, String? imageUrl) {
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
  }

  @override
  Widget build(BuildContext context) {
    if(news.isEmpty){
      return Scaffold(
        extendBodyBehindAppBar: true,
        body:
          Stack(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              CustomAppBar(titleText: 'Лента новостей', chapterText: 'СОШ №9', onPrevious: () {Navigator.pushNamed(context, '/');})
            ],
          )
      );
    }
    if (news[0].keys.first == 'error_code'){
      return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: ErrorHandler(errorCode: news[0]['error_code']!)
            ),
            CustomAppBar(titleText: 'Лента новостей', chapterText: 'СОШ №9', onPrevious: () {Navigator.pushNamed(context, '/');})
          ],
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              final item = news[index];
              final imageUrl = item['image'];
              if (index == 0){
                return Padding(
                    padding: EdgeInsets.only(top: 70),
                child: newsCardGen(item, imageUrl));
              }
              else{
                return newsCardGen(item, imageUrl);
              }
            },
          ),
          CustomAppBar(titleText: 'Лента новостей', chapterText: 'СОШ №9', onPrevious: () {Navigator.pushNamed(context, '/');})
        ],
      )
    );
  }
}