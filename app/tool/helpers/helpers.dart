// ignore_for_file: avoid_print

import 'dart:io';

class ToolHelpers {
  static Future<void> createModule() async {
    final currentDir = Directory.current.path;
    _ReplaceRegexHolderHelper.handleGetPathAndScreenName(
      defaultPathInput: "$currentDir/lib/modules",
      onValidInput: (pathInput, fileNameInput) async {
        final className = fileNameInput.toPascalCase();
        final fileName = fileNameInput.toSnakeCase();
        await createFile(
          templatePath:
              "tool/templates/create_module/file_name/file_name_module.dart.tmpl",
          destinationPath: "$pathInput/$fileName/${fileNameInput}_module.dart",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFile(
          templatePath:
              "tool/templates/create_module/file_name/l10n/arbs/intl_en.arb.tmpl",
          destinationPath: "$pathInput/$fileName/l10n/arbs/intl_en.arb",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFile(
          templatePath:
              "tool/templates/create_module/file_name/l10n/arbs/intl_vi.arb.tmpl",
          destinationPath: "$pathInput/$fileName/l10n/arbs/intl_vi.arb",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFolder("$pathInput/$fileName/container");
        const filePath = 'lib/app_localizations_delegate.dart';
        const modulePath = 'lib/app_module.dart';
        await Process.run(
          'make',
          ['generate'],
        );
        final file = File(filePath);
        final moduleFile = File(modulePath);
        String content = await file.readAsString();
        String moduleContent = await moduleFile.readAsString();

        const marker = '// DO NOT DELETE THIS COMMENT';
        final delegateLine = '${className}Localizations.delegate,';
        final moduleName = '${className}Module(),';

        if (!moduleContent.contains(moduleName)) {
          moduleContent = moduleContent.replaceFirst(
            marker,
            '$moduleName\n        $marker',
          );

          await moduleFile.writeAsString(moduleContent);
          print('✅ Đã thêm $moduleName vào app_module.');
        } else {
          print('⚠️ Module đã tồn tại.');
        }

        if (!content.contains(delegateLine)) {
          content = content.replaceFirst(
            marker,
            '$delegateLine\n        $marker',
          );

          await file.writeAsString(content);
          print('✅ Đã thêm $className.delegate vào localizationsDelegates.');
        } else {
          print('⚠️ Delegate đã tồn tại.');
        }

        print("Vui lòng tự fix lỗi import,... ");
      },
    );
  }

  static Future<void> createScreen() async {
    _ReplaceRegexHolderHelper.handleGetPathAndScreenName(
      onValidInput: (pathInput, fileNameInput) async {
        final className = fileNameInput.toPascalCase();
        final fileName = fileNameInput.toSnakeCase();
        print("Đang khởi tạo");
        await createFile(
          templatePath:
              "tool/templates/create_screen/file_name/file_name_screen.dart.tmpl",
          destinationPath: "$pathInput/$fileName/${fileNameInput}_screen.dart",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFile(
          templatePath:
              "tool/templates/create_screen/file_name/file_name_screen_body.dart.tmpl",
          destinationPath:
              "$pathInput/$fileName/${fileNameInput}_screen_body.dart",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFile(
          templatePath:
              "tool/templates/create_screen/file_name/bloc/file_name_bloc.dart.tmpl",
          destinationPath:
              "$pathInput/$fileName/bloc/${fileNameInput}_bloc.dart",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFile(
          templatePath:
              "tool/templates/create_screen/file_name/bloc/file_name_bloc.dart.tmpl",
          destinationPath:
              "$pathInput/$fileName/bloc/${fileNameInput}_bloc.dart",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFile(
          templatePath:
              "tool/templates/create_screen/file_name/bloc/file_name_event.dart.tmpl",
          destinationPath:
              "$pathInput/$fileName/bloc/${fileNameInput}_event.dart",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFile(
          templatePath:
              "tool/templates/create_screen/file_name/bloc/file_name_state.dart.tmpl",
          destinationPath:
              "$pathInput/$fileName/bloc/${fileNameInput}_state.dart",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await createFile(
          templatePath:
              "tool/templates/create_screen/file_name/models/file_name_argument.dart.tmpl",
          destinationPath:
              "$pathInput/$fileName/models/${fileNameInput}_argument.dart",
          from: [RegExp(r'\$ClassName\$'), RegExp(r'\$FileName\$')],
          replace: [className, fileName],
        );
        await Process.run(
          'flutter',
          [
            'pub',
            'run',
            'build_runner',
            'build',
            '--delete-conflicting-outputs'
          ],
        );
        print("Hoàn thành!!!");
      },
    );
  }

  static Future<void> createFolder(String path) async {
    final directory = Directory(path);

    if (!(await directory.exists())) {
      await directory.create(recursive: true);
      print('✅ Folder created at ${directory.path}');
    } else {
      print('📁 Folder already exists at ${directory.path}');
    }
  }

  static Future<void> createFile({
    required String templatePath,
    required String destinationPath,
    List<Pattern>? from,
    List<String>? replace,
  }) async {
    try {
      final File file = await File(destinationPath).create(recursive: true);
      final newContent = await _ReplaceRegexHolderHelper.copyFromTemplate(
        sourcePath: templatePath,
        from: from ?? [],
        replace: replace ?? [],
      );
      await file.writeAsString(newContent);
    } catch (e) {
      print("Error: $e");
    }
  }
}

class _ReplaceRegexHolderHelper {
  static Future<String> copyFromTemplate({
    required String sourcePath,
    required List<Pattern> from,
    required List<String> replace,
  }) async {
    try {
      var sourceFile = await File(sourcePath).readAsString();

      // print("Old file: $from");
      for (var i = 0; i < from.length; i++) {
        sourceFile = sourceFile.replaceAll(from[i], replace[i]);
      }
      // print("New file: $sourceFile");

      return sourceFile;
    } catch (e) {
      print("copyFromTemplate: $e");
      return "";
    }
  }

  static Future<void> handleGetPathAndScreenName({
    required void Function(
      String pathInput,
      String fileNameInput,
    ) onValidInput,
    String? defaultPathInput,
  }) async {
    // Đường dẫn folder
    // bool isFilePathValid = false;
    bool isFileNameValid = false;
    bool filePathExits = false;
    String fileNameInput = '';
    String? targetPath;
    if (defaultPathInput == null || defaultPathInput.isEmpty) {
      print("Vui lòng nhập đường dẫn file bạn muốn tạo");
      targetPath = stdin.readLineSync()?.trim().replaceAll("'", "") ?? '';
    } else {
      print("Đường dẫn mặc định $defaultPathInput");
      targetPath = defaultPathInput;
    }

    try {
      do {
        print("Nhập tên file muốn tạo");
        fileNameInput = stdin.readLineSync()?.trim() ?? '';
        isFileNameValid = _FileNameValidator.isFileNameValid(fileNameInput);
        final directory = Directory("$targetPath/$fileNameInput");
        filePathExits = directory.existsSync();
        if (filePathExits) {
          print("File đã tồn tại. Xin vui lòng thử lại");
          continue;
        }

        if (!isFileNameValid) {
          print('Tên file không hợp lệ! Vui lòng thử lại: ');
        } else {
          isFileNameValid = true;
        }
      } while (filePathExits || !isFileNameValid);
      onValidInput(targetPath, fileNameInput);
    } catch (e) {
      throw Exception(e);
    }
  }
}

class _FileNameValidator {
  static bool isFileNameValid(String fileName) {
    return fileName.isNotEmpty || fileName.contains(RegExp(r'[,;:!@#$%^&*()]'));
  }
}

extension StringExt on String {
  ///
  /// Hello World => hello_world
  ///
  String toSnakeCase({String? splitValue}) {
    return split(splitValue ?? " ").map((e) => e.toLowerCase()).join("_");
  }

  ///
  /// hello_world => HelloWorld
  ///

  String toPascalCase({String? splitValue}) {
    return split(splitValue ?? '_').map((word) {
      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '';
    }).join('');
  }

  ///
  /// hello_world => helloWorld
  ///

  String toCamelCase({String? splitValue}) {
    List<String> words = split(splitValue ?? '_');
    if (words.isEmpty) return '';

    // Chữ cái đầu tiên viết thường, các chữ sau viết hoa chữ cái đầu
    String firstWord = words[0].toLowerCase();
    String camelCase = words.skip(1).map((word) {
      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '';
    }).join('');

    return firstWord + camelCase;
  }
}
