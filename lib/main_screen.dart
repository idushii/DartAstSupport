import 'package:dart_ast_support/select_folder.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Данное приложение является демонстрационным. \nЕго цель представить ваш dart class в виде json массива.'),
            SelectFolder(),
          ],
        ),
      ),
    );
  }
}
