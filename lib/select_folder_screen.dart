import 'dart:convert';
import 'dart:io';

import 'package:dart_ast_support/select_folder.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

String basePathProject = '';
var items = [];

class SelectFolderScreen extends StatefulWidget {
  @override
  _SelectFolderScreenState createState() => _SelectFolderScreenState();
}

class _SelectFolderScreenState extends State<SelectFolderScreen> {
  Directory rootPath;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    rootPath = await getApplicationDocumentsDirectory();
  }

  String path = '';

  selectFolder() async {
    path = await FilesystemPicker.open(
      title: 'Save to folder',
      context: context,
      rootDirectory: rootPath,
      fsType: FilesystemType.all,
      pickText: 'Save file to this folder',
      folderIconColor: Colors.teal,
    );

    if (path == null) return;

    basePathProject = path;

    List contents = Directory(path).listSync(recursive: true);

    List<File> files = [];

    for (var fileOrDir in contents) {
      if (fileOrDir is File) {
        if (p.extension(fileOrDir.path) == '.dart') {
          files.add(fileOrDir.absolute);
        }
      } else if (fileOrDir is Directory) {
        // print(fileOrDir.path);
      }
    }

    await Future.forEach(files, (File element) async {
      final _ast = await parseFile(element);
      items.add({
        'path': element.path.split(basePathProject)[1],
        'name': p.basename(element.path),
        'content': printMembers(_ast.unit),
      });
    });

    print(items.length);

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(onPressed: selectFolder, child: Text('Выбрать папку')),
            if (path.isNotEmpty) Text("Выбрана папка ${path}"),
            if (path.isNotEmpty) Text("Всего найдено файлов ${items.length}"),
          ],
        ),
      ),
    );
  }
}
