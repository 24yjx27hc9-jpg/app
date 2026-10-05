import 'package:flutter/material.dart';
import 'package:flutter_notes/database/database_class.dart';
import 'package:flutter_notes/main_interface_elements/bottom_bar.dart';
import 'package:flutter_notes/main_interface_elements/custom_app_bar.dart';

class NotePage extends StatefulWidget{
  const NotePage({super.key});

  @override
  State<StatefulWidget> createState() => _NotePage();
}

class _NotePage extends State<NotePage>{
  String? idNote;
  bool isEditing = false;
  List note = [];
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode textFocusNode = FocusNode();
  late final TextEditingController titleController = TextEditingController(text: note[0]['title'].toString());
  late final TextEditingController textController = TextEditingController(text: note[0]['text'] != null ? note[0]['text'].toString() : 'У заметки нет текста');

  void startEditing(FocusNode focusNode){
    setState(() {
      isEditing = true;
    });
    WidgetsBinding.instance.addPersistentFrameCallback(
        (_) => focusNode.requestFocus()
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)!.settings.arguments as int;
    setState(() {
      idNote = id.toString();
    });
    getNote();
  }

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    titleFocusNode.dispose();
    textFocusNode.dispose();
    super.dispose();
  }

  Future<void> getNote() async{
    final db = await DatabaseClass().database;
    final noteData = await db.query('Notes', where: 'id = $idNote');
    setState(() {
      note = noteData;
    });
  }
  
  Widget saveButton(){
    return IconButton(
      icon: Icon(Icons.check, color: Colors.white,),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary
      ),
      onPressed: () async{
        final db = await DatabaseClass().database;
        await db.update('Notes', {'title' : titleController.text, 'text' : textController.text}, where: 'id = $idNote');
      },
    );
  }

  Widget textNote(TextEditingController controller, TextStyle? style, FocusNode focusNode){
    return TextField(
      controller: controller,
      maxLines: null,
      style: style,
      readOnly: !isEditing,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none
      ),
      onTap: () {
        if (!isEditing){
          startEditing(focusNode);
        }
      },
    );
  }

  Widget noteContent(List noteData, BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: textNote(titleController, Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black), titleFocusNode),
              ),
              saveButton()
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 90),
            child: textNote(textController, Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black), textFocusNode),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (note.isEmpty){
      return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            BottomBar(),
            CustomAppBar(titleText: 'Загрузка...', chapterText: 'СОШ №9')
          ],
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: noteContent(note, context)
          ),
          BottomBar(),
          CustomAppBar(titleText: note[0]['title'].toString(), chapterText: 'СОШ №9')
        ],
      ),
    );
  }
}