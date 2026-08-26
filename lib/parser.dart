import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

class Parser {
  final String siteUrl;

  Parser({required this.siteUrl});

  Future<List<Map<String, String>>> fetchNewsList(String url) async{
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200){
      throw Exception('Произошла ошибка при отпраке запроса на сайт: ${response.statusCode}');
    }
    final document = parser.parse(response.body);
    final List elements = document.querySelectorAll('div.events-card');
    List<Map<String, String>> news = [];
    for (Element element in elements){
      String newsName = element.querySelector('h3')?.text ?? '';
      String newsAnonsText = element.querySelector('p')?.text ?? '';
      String? newsUrl = siteUrl + element.querySelector('a')!.attributes['href']!;
      String imageSrc = element.querySelector('div.events-card__image')?.querySelector('img')?.attributes['src'] ?? '';
      String newsImg = '';
      if (imageSrc.isNotEmpty){
        newsImg = Uri.parse(url)
            .resolve(imageSrc)
            .toString();
      }
      news.add({
        'name' : newsName,
        'anons_text' : newsAnonsText,
        'image' : newsImg,
        'url' : newsUrl
      });
    }
    return news;
  }

  Future<Map<String, dynamic>> fetchNews(String url) async{
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200){
      throw Exception('При запросе новости произошла ошибка: ${response.statusCode}');
    }
    final document = parser.parse(response.body);
    Map<String, dynamic> news = {};
    String? mainImgUrl = document.querySelector('.container.page_maincontent .clearfix img')?.attributes['src'];
    news['main_img_url'] = mainImgUrl != null ? siteUrl + mainImgUrl : '';
    news['other_img_urls'] = [];
    news['full_size_other_img_urls'] = [];
    news['heading'] = document.querySelector('h1.base-section__title')?.text ?? '';
    news['text'] = document.querySelector('.container.page_maincontent .container p')?.innerHtml ?? '';
    final imgDivs = document.querySelectorAll('.galery .galery-slide img');
    for (Element imgDiv in imgDivs){
      String imgUrl = siteUrl + imgDiv.attributes['src']!;
      news['other_img_urls'].add(imgUrl);
    }
    final fullSizeImg = document.querySelectorAll('.galery a.galery-slide');
    for (Element image in fullSizeImg){
      String imgUrl = siteUrl + image.attributes['href']!;
      news['full_size_other_img_urls'].add(imgUrl);
    }
    return news;
  }

  Future<List<Map<String, String>>> getContacts(String url) async{
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200){
      throw Exception('При запросе для нахождения контактов произошла ошибка: ${response.body}');
    }
    final document = parser.parse(response.body);
    List<Map<String, String>> contacts = [];
    final contactsList = document.querySelectorAll('.col-lg-6.flex-column .footer-info .reset_ul_ol li');
    for (Element contactElement in contactsList){
      if (contactElement.querySelector('a') != null){
        String contact = contactElement.querySelector('a')!.text;
        final elementContact = {
          'Телефон' : contact
        };
        contacts.add(elementContact);
      }
      else{
        String contact = contactElement.text;
        final elementContact = {
          'Адрес' : contact
        };
        contacts.add(elementContact);
      }
    }
    return contacts;
  }
}