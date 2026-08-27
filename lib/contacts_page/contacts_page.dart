import 'package:flutter/material.dart';
import 'package:flutter_notes/parser.dart';

class ContactsPage extends StatefulWidget{
  const ContactsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ContactPage();
}

class _ContactPage extends State<ContactsPage>{
  final parser = Parser(siteUrl: 'https://t67018w.sch.obrazovanie33.ru');
  List<Map<String, String>> contacts = [];
  int? selectIndex;

  @override
  void initState() {
    super.initState();
    loadContacts();
  }
  
  Future<void> loadContacts() async{
    const Map<String, String> maxContact = {
      'MAX' : 'https://max.ru/id3303005571_gos'
    };
    const Map<String, String> vkContact = {
      'VK' : 'https://vk.ru/altairvz'
    };
    final value = await parser.getContacts('https://t67018w.sch.obrazovanie33.ru/');
    if (!mounted) return;
    setState(() {
      contacts = value;
      contacts.add(maxContact);
      contacts.add(vkContact);
    });
  }

  Widget contactBuild (int index) {
    final item = contacts[index];
    final key = item.keys.first;
    final value = item.values.first;
    final bool isSelected = selectIndex == index;
    Widget icon = Center(); //чисто ради затычки этот центр оставил
    switch(index){
      case 0:
        icon = Icon(Icons.phone, color: Colors.black);
      case 1:
        icon = Icon(Icons.maps_home_work_rounded, color: Colors.lightGreen);
      case 2:
        icon = Padding(padding: EdgeInsets.all(4), child: SizedBox(height: 30, width: 30, child: Image.asset('assets/images/contacts/max.png', fit: BoxFit.contain)));
      case 3:
        icon = SizedBox(height: 50, width: 50, child: Image.asset('assets/images/contacts/vk.png', fit: BoxFit.contain));
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          selectIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: isSelected
            ? EdgeInsets.all(10)
            : EdgeInsets.zero,
        height: isSelected
            ? MediaQuery.of(context).size.height
            : 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF4EABC7)),
        borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Column(
          children: [
            Row(
              spacing: 3,
              children: [
                Align(alignment: AlignmentGeometry.centerLeft, child: icon),
                Text(key, textDirection: TextDirection.ltr, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), overflow: TextOverflow.visible,)
              ],
            ),
            Text('Контактные данные: $value', textDirection: TextDirection.ltr, style: TextStyle(fontSize: 17))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Контакты', textDirection: TextDirection.ltr)),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) => contactBuild(index)
          ),
        ],
      )
    );
  }
}