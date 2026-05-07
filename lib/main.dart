import 'package:flutter/material.dart';

void main() {
  runApp(todoapp());
}

class todoapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Todo App"), centerTitle: true),
        body: Container(),
      ),
    );
  }
}
