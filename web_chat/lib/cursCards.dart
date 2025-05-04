import 'package:flutter/material.dart';

class DynamicCardGridView extends StatefulWidget {
  const DynamicCardGridView({super.key});

  @override
  _DynamicCardGridViewState createState() => _DynamicCardGridViewState();
}

class _DynamicCardGridViewState extends State<DynamicCardGridView> {
  List<String> items = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    // Имитация загрузки
    await Future.delayed(const Duration(seconds: 1));

    final newItems =
        List.generate(12, (i) => 'Карточка ${items.length + i + 1}');
    setState(() {
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      itemCount: items.length + (isLoading ? 1 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 карточки в строке
        childAspectRatio: 1.0,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return _buildLoader();
        }
        return Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.black)),
          child: Center(child: Text(items[index])),
        );
      },
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
