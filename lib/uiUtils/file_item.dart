import 'dart:io';


import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

import 'file_icon.dart';

class FileItem extends StatelessWidget {
  final FileSystemEntity file;

  FileItem({
    Key? key,
    required this.file
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => OpenFile.open(file.path),
      contentPadding: EdgeInsets.all(0),
      leading: FileIcon(file: file),
      title: Text(
        '${basename(file.path)}',
        style: TextStyle(fontSize: 14),
        maxLines: 2,
      )
    );
  }
}
