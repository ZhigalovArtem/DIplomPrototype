import 'package:flutter/material.dart';
import 'package:web_chat/StudentsTable.dart';

class CurseScreen extends StatefulWidget {
  final Function function;
  String? name;
  CurseScreen({required this.function, required this.name});
  // const CurseScreen({super.key});

  @override
  State<CurseScreen> createState() => _CurseScreenState(name: name);
}

class _CurseScreenState extends State<CurseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? name;
  int selector = 0; // 0 for curse content

  String searchQuery = '';

  _CurseScreenState({required this.name});

  @override
  void dispose() {
    _searchController.dispose(); // Правильное место для dispose()
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
        actions: [
          IconButton(
            onPressed: () {
              widget.function('');
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.05,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ))),
              ),

              //Кнопки ученики/содержание курса
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
                width: MediaQuery.sizeOf(context).width * 0.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          selector = 1;
                          refresh();
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            width: MediaQuery.sizeOf(context).width * 0.1,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: selector == 1
                                        ? Colors.black
                                        : const Color.fromARGB(0, 0, 0, 0),
                                    width: 3),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Ученики',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          selector = 0;
                          refresh();
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.05,
                            width: MediaQuery.sizeOf(context).width * 0.1,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: selector == 0
                                        ? Colors.black
                                        : const Color.fromARGB(0, 0, 0, 0),
                                    width: 3),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Содержание курса',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          selector == 0
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      child: curseContentWidget(context),
                    )
                  ],
                )
              : Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: studentsWidget(context)),
        ],
      ),
    );
  }

//Вкладка ученики
  Widget studentsWidget(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.84,
      // color: const Color.fromARGB(255, 255, 237, 183),
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey, width: 1)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        //Поисковая сторока
                        Container(
                          width: 400,
                          height: 50,
                          child: SearchBar(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                // Прямоугольная форма
                                borderRadius: BorderRadius.circular(
                                    4), // Можно сделать полностью прямоугольным (0)
                                side: const BorderSide(
                                    color: Colors.grey, width: 2),
                              ),
                            ),
                            hintText: 'Поиск по ученикам...',
                            leading: const Icon(Icons.search, size: 20),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.toLowerCase();
                                print(searchQuery);
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                        //Кнопка "добавить учеников"
                        GestureDetector(
                          onTap: () {},
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                                width: 200,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                // color: Colors.black,
                                child: const Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.group_add,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Добавить учеников',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: StudentsTable(
                    searchQuery: searchQuery,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Вкладка содержимое курса
  Widget curseContentWidget(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.84,
      color: const Color.fromARGB(255, 167, 196, 245),
      child: Text('Curse content'),
    );
  }
}
