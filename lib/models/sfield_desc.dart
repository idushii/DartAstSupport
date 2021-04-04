import 'package:flutter/cupertino.dart';

class FieldDesc {
  final String name;
  final String keyword;
  final String type;
  final String defaultValues;

  FieldDesc({
    @required this.name,
    @required this.type,
    @required this.defaultValues,
    @required this.keyword,
  });

  FieldDesc copyWith({
    String name,
    String type,
    String defaultValues,
    String keyword,
  }) =>
      FieldDesc(
        name: name ?? this.name,
        type: type ?? this.type,
        defaultValues: defaultValues ?? this.defaultValues,
        keyword: keyword ?? this.keyword,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
        "defaultValues": defaultValues,
        "keyword": keyword
      };

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "defaultValues": defaultValues,
        "keyword": keyword
      };

  static FieldDesc fromJson(Map<String, dynamic> json) => FieldDesc(
        name: json['name'] as String,
        type: json['type'] as String,
        defaultValues: json['defaultValues'] as String,
        keyword: json['keyword'] as String,
      );

  String toString() =>
      "FieldDesc[name=$name,type=$type,defaultValues=$defaultValues,keyword=$keyword]";
}
