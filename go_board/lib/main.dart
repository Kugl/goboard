import 'package:flutter/material.dart';

import 'game/gameVisu.dart';

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
          Background(),
          //Root of the game which holds the data & logic and serves as the Provider. It also roots the Widget tree
          Game(),
        ]),
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Image.asset(
        'assets/wood4.jpeg',
        width: size.width,
        height: size.height,
        fit: BoxFit.fill,
      ),
    );
  }
}
