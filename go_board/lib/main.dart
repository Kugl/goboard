import 'package:flutter/material.dart';

import 'draw.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoBoard',
      home: Scaffold(
          appBar: AppBar(
            title: Text("GoBoard"),
          ),
          body: Stack(children: [
            Cross(),
            Grid(),
          ])),
    );
  }
}

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: generateGrid(rows: 5, columns: 5),
      ),
    );
  }

  List<Widget> generateGrid({int rows = 1, int columns = 1}) {
    List<Widget> list = new List();
    for (var i = rows; i >= 1; i--) {
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: generateRow(items: columns),
        ),
      );
    }
    return list;
  }

  List<Widget> generateRow({int items = 0}) {
    List<Widget> list = new List();
    for (var i = items; i >= 1; i--) {
      //TODO: Change to dynamic
      list.add(Stone());
    }
    return list;
  }
}

class Stone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

class StoneDiv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(padding: const EdgeInsets.all(2.0), child: Divider()),
    );
  }
}
