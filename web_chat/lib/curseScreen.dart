import 'package:flutter/material.dart';

class CurseScreen extends StatefulWidget {
  final Function function;
  String? name;
  CurseScreen({required this.function, required this.name});
  // const CurseScreen({super.key});

  @override
  State<CurseScreen> createState() => _CurseScreenState(name: name);
}

class _CurseScreenState extends State<CurseScreen> {
  String? name;
  int selector = 0; // 0 for curse content

  _CurseScreenState({required this.name});

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.2,
                child: selector == 0
                    ? curseContentWidget(context)
                    : tutorsWidget(context),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget tutorsWidget(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.84,
      color: const Color.fromARGB(255, 255, 237, 183),
      child: Text('Tutors'),
    );
  }

  Widget curseContentWidget(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.84,
      color: const Color.fromARGB(255, 167, 196, 245),
      child: Text('Curse content'),
    );
  }
}
