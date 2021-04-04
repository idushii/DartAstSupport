
import 'package:flutter/cupertino.dart';

class HasProps {
  final bool hasToString;
  final bool hasToMap;
  final bool hasToJson;
  final bool hasFromJson;
  final bool hasCopyWith;

  HasProps({
    @required this.hasToString,
    @required this.hasToMap,
    @required this.hasToJson,
    @required this.hasFromJson,
    @required this.hasCopyWith,
  });

  HasProps copyWith({
    bool hasToString,
    bool hasToMap,
    bool hasToJson,
    bool hasFromJson,
    bool hasCopyWith,
  }) =>
      HasProps(
        hasToString: hasToString ?? this.hasToString,
        hasToMap: hasToMap ?? this.hasToMap,
        hasToJson: hasToJson ?? this.hasToJson,
        hasFromJson: hasFromJson ?? this.hasFromJson,
        hasCopyWith: hasCopyWith ?? this.hasCopyWith,
      );

  Map<String, dynamic> toMap() => {
    "hasToString": hasToString,
    "hasToMap": hasToMap,
    "hasToJson": hasToJson,
    "hasFromJson": hasFromJson,
    "hasCopyWith": hasCopyWith
  };

  Map<String, dynamic> toJson() => {
    "hasToString": hasToString,
    "hasToMap": hasToMap,
    "hasToJson": hasToJson,
    "hasFromJson": hasFromJson,
    "hasCopyWith": hasCopyWith
  };

  static HasProps fromJson(Map<String, dynamic> json) => HasProps(
    hasToString: json['hasToString'] as bool,
    hasToMap: json['hasToMap'] as bool,
    hasToJson: json['hasToJson'] as bool,
    hasFromJson: json['hasFromJson'] as bool,
    hasCopyWith: json['hasCopyWith'] as bool,
  );

  String toString() =>
      "HasProps[hasToString=$hasToString,hasToMap=$hasToMap,hasToJson=$hasToJson,hasFromJson=$hasFromJson,hasCopyWith=$hasCopyWith]";
}
