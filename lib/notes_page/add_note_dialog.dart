import 'package:flutter/material.dart';
import 'package:flutter_notes/database/database_class.dart';

class AddNoteDialog extends StatefulWidget{
  const AddNoteDialog({super.key});

  @override
  State<StatefulWidget> createState() => _AddNoteDialog();
}

class _AddNoteDialog extends State<AddNoteDialog>{
  final titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 190,
          minHeight: 130,
          maxWidth: 500,
          minWidth: 300
        ),
        child:  Padding(
          padding: EdgeInsets.all(15),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Создание заметки', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black), textAlign: TextAlign.start),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Название',
                  hintText: 'Введите название заметки',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: Text('Отмена', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                  TextButton(
                    onPressed: () async{
                      final db = await DatabaseClass().database;
                      await db.insert('Notes', {'title' : titleController.text});
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: Text('Создать', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}