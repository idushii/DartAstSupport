import 'package:flutter/material.dart';
import 'package:filepicker_windows/filepicker_windows.dart';

class SelectFolder extends StatefulWidget {
  @override
  _SelectFolderState createState() => _SelectFolderState();
}

class _SelectFolderState extends State<SelectFolder> {
  String path = '';

  get textFolder => path.isNotEmpty ? path : "Не выбрана папка";

  @override
  Widget build(BuildContext context) {
    final file = OpenFilePicker()
      ..filterSpecification = {
        'dart file (*.dart)': '*.dart',
        'All Files': '*.*'
      }
      ..defaultFilterIndex = 0
      ..defaultExtension = 'dart'
      ..title = 'Выберите файл dart';

    return GestureDetector(
      onTap: () {
        file.getFile();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
        ),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Text(textFolder),
            Spacer(),
            Text('Выбрать', style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
