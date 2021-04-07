import 'package:flutter/cupertino.dart';

class FieldDesc {
  final String name;
  final String keyword;
  final String type;
  final String defaultValues;
  final bool isStatic;

  FieldDesc({
    @required this.name,
    @required this.type,
    @required this.defaultValues,
    @required this.keyword,
    @required this.isStatic,
  });

  FieldDesc copyWith({
    String name,
    String type,
    String defaultValues,
    String keyword,
    bool isStatic,
  }) =>
      FieldDesc(
        name: name ?? this.name,
        type: type ?? this.type,
        defaultValues: defaultValues ?? this.defaultValues,
        keyword: keyword ?? this.keyword,
        isStatic: isStatic ?? this.isStatic,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
        "defaultValues": defaultValues,
        "keyword": keyword,
        "isStatic": isStatic,
      };

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "defaultValues": defaultValues,
        "keyword": keyword,
        "isStatic": isStatic,
      };

  static FieldDesc fromJson(Map<String, dynamic> json) => FieldDesc(
        name: json['name'] as String,
        type: json['type'] as String,
        defaultValues: json['defaultValues'] as String,
        keyword: json['keyword'] as String,
        isStatic: json['isStatic'] as bool,
      );

  String toString() =>
      "FieldDesc[name=$name,type=$type,defaultValues=$defaultValues,keyword=$keyword,isStatic=$isStatic]";
}
