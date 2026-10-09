import 'package:flutter/material.dart';
import 'package:flutter_notes/parser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_notes/error_handler.dart';

class Carousel extends StatefulWidget{
  const Carousel({super.key});

  @override
  State<StatefulWidget> createState() => _Carousel();
}

class _Carousel extends State<Carousel>{
  Parser parser = Parser(siteUrl: 'https://t67018w.sch.obrazovanie33.ru');
  final PageController _pageController = PageController();
  int currentPage = 0;
  Map<String, Map<String, dynamic>> carousel = {};

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadCarousel();
  }

  Future<void> loadCarousel() async{
    try{
      final value = await parser.getCarousel();
      if (!mounted) return;
      setState(() {
        carousel = value;
      });
    }
    catch(e){
      debugPrint('Ошибка загрузки карусели: $e');
    }
  }

  Widget pageStyle(Widget child){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueGrey.withValues(alpha: 1),
            Colors.blueGrey.withValues(alpha: 0.9),
            Colors.blueGrey.withValues(alpha: 0.8),
            Colors.blueGrey.withValues(alpha: 0.7),
            Colors.blueGrey.withValues(alpha: 0.6),
            Colors.blueGrey.withValues(alpha: 0.5),
            Colors.blueGrey.withValues(alpha: 0.6),
            Colors.blueGrey.withValues(alpha: 0.7),
            Colors.blueGrey.withValues(alpha: 0.85),
            Colors.blueGrey.withValues(alpha: 1),
          ],
          stops: const[
            0,
            0.10,
            0.20,
            0.30,
            0.40,
            0.50,
            0.60,
            0.70,
            0.85,
            1
          ]
        )
      ),
      child: child
    );
  }

  Widget thisPageIndicator(int currentPage, int id) {
    return Icon(Icons.circle, color: id == currentPage ? Colors.white : Colors.grey, size: 10,);
  }

  Widget startPage() {
    Widget image = Image.network(carousel['start_page']!['image_URL']);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 5,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Качественное образование', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Text('Сегодня', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.tertiaryContainer, fontFamily: 'Manrope', fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
              Text('Успешное будущее - завтра!', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),)
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image,
          ),
          Row(
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              thisPageIndicator(currentPage, 0),
              thisPageIndicator(currentPage, 1),
              thisPageIndicator(currentPage, 2)
            ],
          )
        ],
      ),
    );
  }

  Widget directorWords() {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium;
    return Column(
      spacing: 5,
      children: [
        Expanded(
          child: Row(
            spacing: 10,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(carousel['director_words']!['heading'], style: Theme.of(context).textTheme.titleMedium?.copyWith(fontFamily: 'Manrope', fontWeight: FontWeight.w700), maxLines: 3),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Html(data: carousel['director_words']!['text'],
                            style: {'*' : Style(
                              color: textStyle?.color,
                              fontFamily: textStyle?.fontFamily,
                              fontWeight: textStyle?.fontWeight,
                              fontSize: FontSize(textStyle?.fontSize ?? 16),
                              lineHeight: textStyle?.fontSize != null
                                ? LineHeight(textStyle!.height!)
                                : null
                            )},
                            onLinkTap: (url, element, attributes) async{
                              if (url?.startsWith('http') ?? false){
                                await launchUrl( Uri.parse(url!),
                                  mode: LaunchMode.externalApplication );
                              }
                            },
                          ),
                        )
                      ),
                    ],
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
                        carousel['director_words']!['image_URL'],
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
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            thisPageIndicator(currentPage, 0),
            thisPageIndicator(currentPage, 1),
            thisPageIndicator(currentPage, 2)
          ],
        )
      ],
    );
  }

  Widget aboutSchool() {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium;
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('О школе', style: Theme.of(context).textTheme.titleMedium),
          Expanded(
            child: SingleChildScrollView(
              child: Html(data: carousel['about_school']?['text'] ?? 'PENIS',
                style: {'*' : Style(
                  color: textStyle?.color,
                  fontFamily: textStyle?.fontFamily,
                  fontWeight: textStyle?.fontWeight,
                  fontSize: FontSize(textStyle?.fontSize ?? 16),
                  lineHeight: textStyle?.fontSize != null
                    ? LineHeight(textStyle!.height!)
                    : null
                )},
                onLinkTap: (url, element, attributes) async{
                  if (url?.startsWith('http') ?? false){
                    await launchUrl( Uri.parse(url!),
                      mode: LaunchMode.externalApplication );
                  }
                },
              ),
            ),
          ),
          Row(
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              thisPageIndicator(currentPage, 0),
              thisPageIndicator(currentPage, 1),
              thisPageIndicator(currentPage, 2)
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (carousel.isEmpty){
      return SizedBox(
        height: 280,
        child: Center(child: CircularProgressIndicator(),),
      );
    }
    if (carousel['status_code']!['status_code'] != '200'){
      return ErrorHandler(errorCode: carousel['status_code']!['status_code']);
    }
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      onPageChanged: (page) {
        setState(() {
          currentPage = page;
        });
      },
      children: [
        pageStyle(startPage()),
        pageStyle(directorWords()),
        pageStyle(aboutSchool())
      ],
    );
  }
}