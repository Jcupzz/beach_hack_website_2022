import 'package:beach_hack_website_2022/Homepage.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final game = Homepage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameWidget(
        game: game,
        loadingBuilder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      ),
    ); //djfiodjf
  }
}
