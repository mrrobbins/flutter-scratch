import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;

read_yaml_asset(String filePath) async {
  var content = await rootBundle.loadString(filePath);
  var data = loadYaml(content);
  return data;
}