import 'package:flutter/material.dart';

class addStudentDialog extends StatefulWidget {
  const addStudentDialog({super.key});

  @override
  State<addStudentDialog> createState() => _addStudentDialog();
}

class _addStudentDialog extends State<addStudentDialog> {
  List<Map<String, dynamic>> addStudent_testList = [];
  final addStudentFormKey = GlobalKey<FormState>();
  String? studentName;
  String? studentSurname;
  String? studentEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.05,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.grey,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Добавить учеников'),
            ),
          ),
          Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.35,
              color: Colors.green,
              child: addStudent_testList.length != 0
                  ? ListView.builder(
                      itemCount: addStudent_testList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Form(
                            key: addStudentFormKey,
                            child: Column(
                              children: [
                                Text('Ученик ${index + 2}'),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'email'),
                                  onSaved: (newValue) =>
                                      studentEmail = newValue!,
                                  onChanged: (value) => studentEmail = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Введите почту';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Имя'),
                                  onSaved: (newValue) =>
                                      studentName = newValue!,
                                  onChanged: (value) => studentName = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Введите имя';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Фамилия'),
                                  onSaved: (newValue) =>
                                      studentSurname = newValue!,
                                  onChanged: (value) => studentSurname = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Введите фамилию';
                                    }
                                    return null;
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Form(
                        key: addStudentFormKey,
                        child: Column(
                          children: [
                            Text('Ученик 1'),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'email'),
                              onSaved: (newValue) => studentEmail = newValue!,
                              onChanged: (value) => studentEmail = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите почту';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Имя'),
                              onSaved: (newValue) => studentName = newValue!,
                              onChanged: (value) => studentName = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите имя';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Фамилия'),
                              onSaved: (newValue) => studentSurname = newValue!,
                              onChanged: (value) => studentSurname = value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите фамилию';
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                    )),

          //Кнопка "Ещё один ученик"
          GestureDetector(
            onTap: () {
              var form = addStudentFormKey.currentState;
              if (form!.validate()) {
                form.save();
              }
              addStudent_testList.add({
                'email': studentEmail,
                'name': studentName,
                'surname': studentEmail
              });
              setState(() {});
              print(addStudent_testList.length);
            },
            child: Container(width: 50, height: 50, color: Colors.black),
          )
        ]));
  }
}
