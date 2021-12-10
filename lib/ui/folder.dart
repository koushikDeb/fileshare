import 'dart:io';


import 'package:fileshare/uiUtils/custom_divider.dart';
import 'package:fileshare/uiUtils/dir_item.dart';
import 'package:fileshare/uiUtils/file_item.dart';
import 'package:fileshare/uiUtils/path_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Folder extends StatefulWidget {
  final String title;
  final String path;

  Folder({
    Key? key,
    required this.title,
    required this.path,
  }) : super(key: key);

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> with WidgetsBindingObserver {
  late String path;
  List<String> paths = <String>[];

  List<FileSystemEntity> files = <FileSystemEntity>[];
  bool showHidden = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchFiles();
    }
  }

  fetchFiles() async {
    try {
      Directory dir = Directory(path);
      List<FileSystemEntity> dirFiles = dir.listSync();
      files.clear();
      showHidden = false;
      setState(() {});
      for (FileSystemEntity file in dirFiles) {
        files.add(file);
        setState(() {});
      }
      files.sort((FileSystemEntity f1, FileSystemEntity f2) => f1.statSync().size.compareTo(f2.statSync().size));
    } catch (e) {
      if (e.toString().contains('Permission denied')) {
        Fluttertoast.showToast(
          msg: 'Permission Denied! cannot access this Directory!',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
        );
        navigateBack();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    path = widget.path;
    fetchFiles();
    paths.add(widget.path);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  navigateBack() {
    paths.removeLast();
    path = paths.last;
    setState(() {});
    fetchFiles();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (paths.length == 1) {
          return true;
        } else {
          paths.removeLast();
          setState(() {
            path = paths.last;
          });
          fetchFiles();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (paths.length == 1) {
                Navigator.pop(context);
              } else {
                navigateBack();
              }
            },
          ),
          elevation: 4,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${widget.title}'),
              Text(
                '$path',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          bottom: PathIndicator(
            paths: paths,
            icon: widget.path.toString().contains('emulated')
                ? Feather.smartphone
                : Icons.sd_card,
            onChanged: (index) {
              print(paths[index]);
              path = paths[index];
              paths.removeRange(index + 1, paths.length);
              setState(() {});
              fetchFiles();
            },
          )
        ),
        body: Visibility(
          replacement: Center(child: Text('There\'s nothing here')),
          visible: files.isNotEmpty,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 20),
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              FileSystemEntity file = files[index];
              if (file.toString().split(':')[0] == 'Directory') {
                return DirectoryItem(
                  file: file,
                  tap: () {
                    paths.add(file.path);
                    path = file.path;
                    setState(() {});
                    fetchFiles();
                  },
                );
              }
              return FileItem(
                file: file,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return CustomDivider();
            },
          ),
        ),

      ),
    );
  }

}
