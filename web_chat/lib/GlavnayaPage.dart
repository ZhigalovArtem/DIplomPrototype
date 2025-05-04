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
          )
        ],
      ),
    );
  }
}
