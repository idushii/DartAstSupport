import 'package:dart_ast_support/models/models.dart';
import 'package:flutter/cupertino.dart';

class ClassDesc {
  final String name;
  final List<FieldDesc> fields;
  final HasProps hasProps;

  ClassDesc({
    @required this.name,
    @required this.fields,
    @required this.hasProps,
  });

  ClassDesc copyWith({
    String name,
    List<FieldDesc> fields,
    HasProps hasProps,
  }) =>
      ClassDesc(
        name: name ?? this.name,
        fields: fields ?? this.fields,
        hasProps: hasProps ?? this.hasProps,
      );

  Map<String, dynamic> toMap() =>
      {"name": name, "fields": fields, "hasProps": hasProps};

  Map<String, dynamic> toJson() =>
      {"name": name, "fields": fields, "hasProps": hasProps};

  static ClassDesc fromJson(Map<String, dynamic> json) => ClassDesc(
    name: json['name'] as String,
    fields: json['fields'] as List<FieldDesc>,
    hasProps: json['hasProps'] as HasProps,
  );

  String toString() =>
      "ClassDesc[name=$name,fields=$fields,hasProps=$hasProps]";
}
