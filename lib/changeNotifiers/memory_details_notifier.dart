import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';


class MemoryDetailsNotifier extends ChangeNotifier{
  List<FileSystemEntity> availableStorage = <FileSystemEntity>[];

  int totalSpace = 0;
  int freeSpace = 0;
  int totalSDSpace = 0;
  int freeSDSpace = 0;
  int usedSpace = 0;
  int usedSDSpace = 0;



  checkSpace() async {



  availableStorage.clear();
  List<Directory> dirList = (await getExternalStorageDirectories())!;
  availableStorage.addAll(dirList);
  notifyListeners();
  MethodChannel platform = MethodChannel('com.iodroid.fileshare/storage');
  var free = await platform.invokeMethod('getStorageFreeSpace');
  var total = await platform.invokeMethod('getStorageTotalSpace');
  setFreeSpace(free);
  setTotalSpace(total);
  setUsedSpace(total - free);

  if (dirList.length > 1) {
  var freeSD = await platform.invokeMethod('getExternalStorageFreeSpace');
  var totalSD = await platform.invokeMethod('getExternalStorageTotalSpace');
  setFreeSDSpace(freeSD);
  setTotalSDSpace(totalSD);
  setUsedSDSpace(totalSD - freeSD);
  }



  }

  void setFreeSpace(value) {
  freeSpace = value;
  notifyListeners();
  }

  void setTotalSpace(value) {
  totalSpace = value;
  notifyListeners();
  }

  void setUsedSpace(value) {
  usedSpace = value;
  notifyListeners();
  }

  void setFreeSDSpace(value) {
  freeSDSpace = value;
  notifyListeners();
  }

  void setTotalSDSpace(value) {
  totalSDSpace = value;
  notifyListeners();
  }

  void setUsedSDSpace(value) {
  usedSDSpace = value;
  notifyListeners();
  }


}

