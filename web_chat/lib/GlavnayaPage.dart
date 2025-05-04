import 'package:flutter/material.dart';

class GlavnayaPage extends StatefulWidget {
  const GlavnayaPage({super.key});

  @override
  State<GlavnayaPage> createState() => _GlavnayaPageState();
}

class _GlavnayaPageState extends State<GlavnayaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Курсы'),
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                color: Colors.black,
              ))),
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.07,
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //поисковая строка
                Container(
                  height: 50,
                  child: SearchBar(
                    // constraints:
                    //     const BoxConstraints(maxHeight: 50), // Уменьшаем высоту
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        // Прямоугольная форма
                        borderRadius: BorderRadius.circular(
                            4), // Можно сделать полностью прямоугольным (0)
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    hintText: 'Поиск...',
                    leading:
                        const Icon(Icons.search, size: 20), // Уменьшаем иконку
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                //кнопка "Создать курс"
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 0, left: 0, right: 10, top: 0),
                  child: GestureDetector(
                      child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 150,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            'Создать курс',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
