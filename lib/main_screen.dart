import 'package:dart_ast_support/select_folder.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var text = '';

  onSelectFile(String text) {
    setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Данное приложение является демонстрационным. \nЕго цель представить ваш dart class в виде json массива.'),
            SelectFolder(onSelectFile: onSelectFile),
            Expanded(
              child: SingleChildScrollView(
                child: Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
