import 'package:flutter/material.dart';
import 'package:web_chat/variables.dart';

class StudentsTable extends StatefulWidget {
  // const StudentsTable({super.key});
  final String searchQuery;
  StudentsTable({required this.searchQuery});

  @override
  State<StudentsTable> createState() => _StudentsTableState();
}

class _StudentsTableState extends State<StudentsTable> {
  late List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    filteredItems = students;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant StudentsTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _filterItems();
    }
  }

  void _filterItems() {
    if (widget.searchQuery.isEmpty) {
      setState(() {
        filteredItems = students;
      });
    } else {
      setState(() {
        filteredItems = students.where((item) {
          return item['name'].toLowerCase().contains(widget.searchQuery);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Заголовок таблицы
        DataTable(
          columns: const [
            DataColumn(
                label: Text(
              'Фамилия Имя',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            DataColumn(
                label: Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            DataColumn(
                label: Text(
              'Суммарный балл',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            DataColumn(
                label: Text(
              'Общий балл за курс',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            DataColumn(
                label: Text(
              'Статус',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
          ],
          rows: [],
        ),
        //Содержимое таблицы
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
              headingRowHeight: 0, // Скрываем заголовок
              columns: const [
                DataColumn(
                    label: Text(
                  'Фамилия Имя',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  'Суммарный балл',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  'Общий балл за курс',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
                DataColumn(
                    label: Text(
                  'Статус',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
              ],
              rows: filteredItems.map((student) {
                return DataRow(cells: [
                  DataCell(Text(
                    student['name'] ?? '',
                    textAlign: TextAlign.center,
                  )), // Добавьте реальные поля
                  DataCell(Text(
                    student['email'] ?? '',
                    textAlign: TextAlign.center,
                  )),
                  DataCell(Text(
                    student['totalScore']?.toString() ?? '0',
                    textAlign: TextAlign.center,
                  )),
                  DataCell(Text(
                    student['courseScore']?.toString() ?? '0',
                    textAlign: TextAlign.center,
                  )),
                  DataCell(Text(student['status'] ?? '')),
                ]);
              }).toList()),
        ))
      ],
    );
  }
}
