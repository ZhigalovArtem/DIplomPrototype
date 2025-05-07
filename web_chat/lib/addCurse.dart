import 'package:flutter/material.dart';
import 'package:web_chat/variables.dart';

class addCurse extends StatefulWidget {
  BuildContext context;
  final VoidCallback function;
  addCurse({required this.context, required this.function});

  @override
  State<addCurse> createState() => _addCurseState();
}

class _addCurseState extends State<addCurse> {
  final key = GlobalKey<FormState>();
  String? name;

  addCurse(name) {
    curses.add(name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Название'),
                    onSaved: (newValue) => name = newValue!,
                    onChanged: (value) => name = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите название';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  var form = key.currentState;
                  if (form!.validate()) {
                    form.save();
                    Navigator.pop(context);
                    addCurse(name);
                    widget.function();
                  }
                },
                child: Text('Добавить'))
          ],
        ),
      ),
    );
  }
}
