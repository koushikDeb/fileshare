import 'dart:async';

import 'package:fileshare/ui/memory_content.dart';


import 'package:fileshare/utils/navigate.dart';
import 'package:fileshare/utils/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  startTimeout() {
    return Timer(Duration(seconds: 2), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      requestPermission();
    } else {
      Navigate.pushPageReplacement(context, MemoryContent());
    }
  }

  requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      Navigate.pushPageReplacement(context, MemoryContent());
    } else {
      Fluttertoast.showToast(
        msg: 'Please Grant Storage Permissions',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    startTimeout();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness:
        Theme.of(context).primaryColor == ThemeConfig.darkTheme.primaryColor
            ? Brightness.light
            : Brightness.dark,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Feather.box,
              color: ThemeConfig.lightBG,
              size: 100.0,
            ),
            SizedBox(height: 120.0),
            Text(
              "FileDroid",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
