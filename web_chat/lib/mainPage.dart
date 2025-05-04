import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Список виджетов для отображения
  final List<Widget> _contentWidgets = [
    const Center(
        child: Text('Главная страница', style: TextStyle(fontSize: 24))),
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
                    label: Text('Профиль'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('Настройки'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.history),
                    label: Text('История'),
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
