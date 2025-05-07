import 'package:flutter/material.dart';
import 'package:web_chat/addCurse.dart';
import 'package:web_chat/cursCards.dart';
import 'package:web_chat/curseScreen.dart';

class GlavnayaPage extends StatefulWidget {
  const GlavnayaPage({super.key});

  @override
  State<GlavnayaPage> createState() => _GlavnayaPageState();
}

class _GlavnayaPageState extends State<GlavnayaPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  // final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool curseScreen = false;
  String? curseName;

  @override
  void dispose() {
    _searchController.dispose(); // Правильное место для dispose()
    super.dispose();
  }

  changeScreen(String? name) {
    curseName = name;
    if (curseScreen == false) {
      curseScreen = true;
    } else {
      curseScreen = false;
    }
    print(curseScreen);
    refresh();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (curseScreen == false) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //поисковая строка
                  Container(
                    height: 50,
                    child: SearchBar(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                      },

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
                      leading: const Icon(Icons.search,
                          size: 20), // Уменьшаем иконку
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                      ),
                      onTap: () {
                        BuildContext dialog = context;
                        var createCurse = showDialog(
                          context: dialog,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                child: Column(children: [
                                  Container(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.07,
                                    child: const Text('Создание курса'),
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  addCurse(
                                    context: context,
                                    function: refresh,
                                  ),
                                ]),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   width: MediaQuery.sizeOf(context).width,
            //   height: MediaQuery.sizeOf(context).height *
            //       0.81, // или конкретное значение (300)
            //   child: DynamicCardGridView(),
            // )

            Expanded(
              child: DynamicCardGridView(
                  searchQuery: _searchQuery, function: changeScreen),
            ),

            // Expanded(
            //   child: Navigator(
            //     key: _navigatorKey,
            //     onGenerateRoute: (settings) {
            //       return MaterialPageRoute(
            //         builder: (context) =>
            //             DynamicCardGridView(searchQuery: _searchQuery),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      );
    } else {
      return CurseScreen(
        function: changeScreen,
        name: curseName,
      );
    }
  }
}
