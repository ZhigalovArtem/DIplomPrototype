import 'package:flutter/material.dart';
import 'package:web_chat/variables.dart';

class DynamicCardGridView extends StatefulWidget {
  final String searchQuery;

  const DynamicCardGridView({super.key, required this.searchQuery});

  @override
  State<DynamicCardGridView> createState() => _DynamicCardGridViewState();
}

class _DynamicCardGridViewState extends State<DynamicCardGridView> {
  // final vars = variables();

  final List<String> allItems =
      List.generate(20, (index) => 'Курс ${index + 1}');
  late List<String> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = curses;
  }

  @override
  void didUpdateWidget(covariant DynamicCardGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _filterItems();
    }
  }

  void _filterItems() {
    if (widget.searchQuery.isEmpty) {
      setState(() {
        filteredItems = allItems;
      });
    } else {
      setState(() {
        filteredItems = allItems.where((item) {
          return item.toLowerCase().contains(widget.searchQuery);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.9,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Center(
              child: Text(
                filteredItems[index],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
