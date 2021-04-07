import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_ast_support/models/models.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:pub_semver/pub_semver.dart';

typedef OnSelectFile(String text);

class SelectFolder extends StatefulWidget {
  final OnSelectFile onSelectFile;

  const SelectFolder({Key key, this.onSelectFile}) : super(key: key);

  @override
  _SelectFolderState createState() => _SelectFolderState();
}

class _SelectFolderState extends State<SelectFolder> {
  String path = '';
  String textAst = '';

  String get textFolder => path.isNotEmpty ? path : "Не выбран файл";

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
      onTap: () async {
        final _file = file.getFile();
        if (_file == null) return;
        final _ast = await parseFile(_file);
        widget.onSelectFile(
            JsonEncoder.withIndent('  ').convert(printMembers(_ast.unit)));
        setState(() {
          path = _file.path;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
        ),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Text(textFolder),
                Spacer(),
                Text('Выбрать', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

ClassDesc printMembers(CompilationUnit unit) {
  var res = [];

  List<FieldDesc> fields = [];
  String name = '';

  ClassDesc classDesc = ClassDesc(
    fields: fields,
    hasProps: HasProps(
      hasCopyWith: true,
      hasFromJson: true,
      hasToJson: true,
      hasToMap: true,
      hasToString: true,
    ),
    name: name,
  );

  for (CompilationUnitMember unitMember in unit.declarations) {
    if (unitMember is ClassDeclaration) {
      res.add("Class ${unitMember.name.name}");
      name = unitMember.name.name;
      classDesc = classDesc.copyWith(name: name);

      for (ClassMember classMember in unitMember.members) {
        if (classMember is MethodDeclaration) {
          // classMember.parameters.toSource();

          // var typeArguments = ((classMember.parameters?.parameters[0].identifier.parent as SimpleFormalParameter).type as NamedType).typeArguments;
          res.add(
              '  Method ${classMember.name} ${classMember.parameters?.parameters?.map((e) => "${e.identifier.parent} ${e.identifier}") ?? ''}: ${classMember.returnType}');
          // res.add('  Method ${classMember.name} ${classMember.parameters?.parameters?.map((e) => "${e.identifier.parent.type.typeArguments.arguments} ${e.identifier}") ?? ''}');
        } else if (classMember is FieldDeclaration) {
          // classMember.fields.

          final _name = classMember.fields.variables[0].name.name;
          final _type = (classMember.fields.type ?? '').toString();
          final _keyword = (classMember.fields.keyword ?? '').toString();
          final _defaultValues = (classMember.fields.variables[0].initializer ?? '').toString();
          final _isStatic = classMember.isStatic;

          fields.add(FieldDesc(
            name: _name,
            type: _type,
            keyword: _keyword,
            defaultValues: _defaultValues,
            isStatic: _isStatic,
          ));

          for (VariableDeclaration field in classMember.fields.variables) {
            res.add('  Variable ${field}');
          }
        } else if (classMember is ConstructorDeclaration) {
          if (classMember.name == null) {
            res.add('  Default constructor ${unitMember.name.name}');
          } else {
            res.add(
                '  Constructor ${unitMember.name.name}.${classMember.name.name}');
          }
        }
      }
    }
  }

  new File('./node_samples.txt').writeAsString(res.join('\n'));

  return classDesc;
}

Future<ParseStringResult> parseFile(File file) async {
  var src = await file.readAsString();
  var ast = parseString(
    content: src,
    featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version.parse('2.10.4'), flags: []),
  );
  return ast;
}
