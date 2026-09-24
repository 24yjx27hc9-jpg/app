import 'package:flutter/material.dart';
import 'package:flutter_notes/parser.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';

class NewsPage extends StatefulWidget{
  const NewsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage>{
  Parser parser = Parser(siteUrl: 'https://t67018w.sch.obrazovanie33.ru');
  Map<String, dynamic> news = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final url = ModalRoute.of(context)!.settings.arguments as String;
    parser.fetchNews(url).then((value) {
      setState(() {
        news = value;
      });
    });
  }

  Widget mainImage() {
    String mainImageUrl = news['main_img_url'] as String;
    List<String> mainImageForGallery = [news['main_img_url']];
    Widget image = GestureDetector(
      onTap: () => galleryViewer(0, mainImageForGallery),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(
              Radius.circular(10)),
          child: Image.network(mainImageUrl))
    );
    final mainImage = mainImageUrl.isEmpty ? const ColoredBox(color: Colors.grey, child: Icon(Icons.image_not_supported_rounded)) : image;
    return Padding(
        padding: EdgeInsets.only(top: 100),
    child: mainImage,);
  }

  Future<void> galleryViewer(int index, List<dynamic> imagesList) async{
    List<String> images = List<String>.from(imagesList);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.black26,
            insetPadding: EdgeInsets.zero,
            child: PhotoViewGallery.builder(
              itemCount: images.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(images[index]),
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Icon(Icons.broken_image));
                    }
                );
              },
              backgroundDecoration: const BoxDecoration(color: Colors.black26),
            ),
          );
        }
    );
  }

  Widget gallery(){
    List imageList = news['other_img_urls'] as List<dynamic>;
    int imageCount = imageList.length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF4EABC7)
        )
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => galleryViewer(index, news['full_size_other_img_urls']),
              child: Container(
                  margin: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: imageList.isEmpty ? Center(child: CircularProgressIndicator()) : Image.network(imageList[index])
              ),
            );
          },
          itemCount: imageCount,
          scrollDirection: Axis.horizontal
      ),
    );
  }

  Widget newsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          mainImage(),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 25),
            child: Html(
              data: news['text'],
              onLinkTap: (url, element, attributes) async{
                if (url?.startsWith('http') ?? false){
                  await launchUrl(
                      Uri.parse(url!),
                      mode: LaunchMode.externalApplication
                  );
                }
              },
            ),
          ),
          Padding(
              padding: EdgeInsetsGeometry.only(bottom: 5),
            child: Align(alignment: AlignmentGeometry.centerLeft,
            child: const Text(
              'Фотографии',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),)
          ),
          SizedBox(
            height: 150,
            child: gallery()
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(news.isEmpty){
      return Scaffold(
        body: Stack(
          children: [
            Center(child: CircularProgressIndicator()),
            CustomAppBar(titleText: 'Загрузка...', chapterText: 'Новости', onPrevious: () {Navigator.pushNamed(context, '/news_page');})
          ],
        )
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          newsContent(),
          CustomAppBar(titleText: news['heading'], chapterText: 'Новости', onPrevious: () {Navigator.pushNamed(context, '/news_page');})
        ],
      )
    );
  }
}