import 'package:flutter/material.dart';
import 'package:web_chat/GlavnayaPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Список виджетов для отображения
  final List<Widget> _contentWidgets = [
    const GlavnayaPage(),
    // const Center(
    //     child: Text('Главная страница', style: TextStyle(fontSize: 24))),
    const Center(
        child: Text('Профиль пользователя', style: TextStyle(fontSize: 24))),
    const Center(
        child: Text('Настройки системы', style: TextStyle(fontSize: 24))),
    const Center(
        child: Text('История действий', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
            padding: EdgeInsets.only(bottom: 0, left: 5, right: 0, top: 5),
            child: Center(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        print('Navigate to profile');
                      },
                      icon: const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      )),
                  GestureDetector(
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'Имя пользователя',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      print('Navigate to profile');
                    },
                  )
                ],
              ),
            )),
        centerTitle: true,
        title: const Text(
          'Название(логотип)',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.nightlight_round_sharp,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.language, color: Colors.white)
        ],
        backgroundColor: Colors.black,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final railWidth = constraints.maxWidth * 0.1;
          return Row(
            children: [
              // Боковое меню
              NavigationRail(
                minWidth: railWidth,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.selected,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Главная'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('Проверка заданий'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.chat_bubble),
                    label: Text('Чат'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.align_horizontal_left),
                    label: Text('Отчёты'),
                  ),
                ],
              ),

              // Вертикальный разделитель
              const VerticalDivider(thickness: 1, width: 1),

              // Основное содержимое (меняется при нажатии)
              Expanded(
                child: _contentWidgets[_selectedIndex],
              ),
            ],
          );
        },
      ),
    );
  }
}
