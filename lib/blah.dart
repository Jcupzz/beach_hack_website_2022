import 'package:flutter/material.dart';

class Blah extends StatefulWidget {
  const Blah({Key? key}) : super(key: key);

  @override
  _BlahState createState() => _BlahState();
}

class _BlahState extends State<Blah> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
