// ignore_for_file: avoid_print

import 'dart:io';

import '../helpers/helpers.dart';

void main(List<String> args) {
  print("Tính năng tạo template");
  print("======================================================");
  print("0. Exit");
  print("1. Tạo module");
  print("2. Tạo 1 màn hình (bao gồm bloc)");
  print("3. Tạo 1 component");
  print("======================================================");
  String? inputSelection;

  inputSelection = stdin.readLineSync()?.trim();

  switch (inputSelection) {
    case "q":
    case "0":
      exit(0);
    case "1":
      ToolHelpers.createModule();
      break;
    case "2":
      ToolHelpers.createScreen();
      break;

    default:
      print("Option không tồn tại. Kết thúc script!!!!");
  }
}
