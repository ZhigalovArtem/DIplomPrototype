import 'package:flutter/material.dart';
import 'package:web_chat/variables.dart';

class addStudentDialog extends StatefulWidget {
  final VoidCallback function;

  const addStudentDialog({super.key, required this.function});

  @override
  State<addStudentDialog> createState() => _addStudentDialogState();
}

class _addStudentDialogState extends State<addStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _studentsList = [];
  String? _studentName;
  String? _studentSurname;
  String? _studentEmail;
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _addStudent() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _studentsList.add({
          'name': '${_studentName} ${_studentSurname}',
          'totalScore': 92,
          'courseScore': 100,
          'status': 'Статус',
          'email': _studentEmail,
        });

        // Очищаем форму
        _nameController.clear();
        _surnameController.clear();
        _emailController.clear();
        _formKey.currentState!.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.05,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.grey,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Добавить учеников'),
            ),
          ),

          // Форма для ввода данных
          Container(
            // height: MediaQuery.sizeOf(context).height * 0.2,
            width: MediaQuery.sizeOf(context).width * 0.3,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Имя'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Введите имя' : null,
                    onSaved: (value) => _studentName = value,
                  ),
                  TextFormField(
                    controller: _surnameController,
                    decoration: const InputDecoration(labelText: 'Фамилия'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Введите фамилию' : null,
                    onSaved: (value) => _studentSurname = value,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Введите email' : null,
                    onSaved: (value) => _studentEmail = value,
                  ),
                ],
              ),
            ),
          ),

          // Список добавленных учеников
          Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: MediaQuery.sizeOf(context).width * 0.4,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _studentsList.length,
              itemBuilder: (context, index) {
                final student = _studentsList[index];
                return ListTile(
                  title: Text('${student['name']}}'),
                  subtitle: Text(student['email'] ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _studentsList.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Кнопка добавления
          ElevatedButton(
            onPressed: _addStudent,
            child: const Text('Добавить ученика'),
          ),

          ElevatedButton(
            onPressed: () {
              students.addAll(_studentsList);
              Navigator.pop(context);
              widget.function();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
